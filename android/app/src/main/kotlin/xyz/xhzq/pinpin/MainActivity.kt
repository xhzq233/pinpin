package xyz.xhzq.pinpin

import android.annotation.SuppressLint
import android.app.*
import android.content.ActivityNotFoundException
import android.content.BroadcastReceiver
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.os.Environment
import android.os.PersistableBundle
import android.provider.Settings
import android.text.TextUtils
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.NewIntentListener
import java.io.File
import java.net.URI


import android.content.ContentValues
import android.media.MediaScannerConnection
import android.net.Uri
import android.os.Build
import android.provider.MediaStore
import android.webkit.MimeTypeMap
import android.os.Looper
import android.os.Handler
import android.content.Context
import kotlin.concurrent.thread

fun Context.saveImage(imageBytes: ByteArray, filename: String): Boolean? {

    //图片已经存在
    if (imageIsExist(filename)) {
        return null
    }

    if (VERSION.SDK_INT < VERSION_CODES.Q) {

        val saveDirectory = File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
            "ChatBox"
        )

        val imageFile = File("${saveDirectory.absolutePath}/$filename")

        val parent = imageFile.parentFile ?: return false

        //目录不存在就创建
        if (!parent.exists() && !parent.mkdirs()) {
            return false
        }

        imageFile.outputStream().use {
            it.write(imageBytes)
        }
        MediaScannerConnection.scanFile(
            this, arrayOf(imageFile.absolutePath), arrayOf(
                MimeTypeMap.getSingleton().getMimeTypeFromExtension(
                    MimeTypeMap.getFileExtensionFromUrl(filename)
                )
            )
        ) { _, _ ->

        }
        return true
    }

    val values = ContentValues()
    //文件名
    values.put(MediaStore.MediaColumns.DISPLAY_NAME, filename)



    values.put(
        MediaStore.MediaColumns.MIME_TYPE,
        MimeTypeMap.getSingleton()
            .getMimeTypeFromExtension(MimeTypeMap.getFileExtensionFromUrl(filename))
    )

    //相册目录
    values.put(
        MediaStore.MediaColumns.RELATIVE_PATH,
        "${Environment.DIRECTORY_PICTURES}/PixivFunc"
    )

    var uri: Uri? = null
    return try {
        uri = contentResolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)
        contentResolver.openOutputStream(uri!!)?.use {
            it.write(imageBytes)
        }
        true
    } catch (e: Exception) {
        uri?.let { contentResolver.delete(it, null, null) }
        false
    }

}


fun Context.imageIsExist(filename: String): Boolean {
    if (VERSION.SDK_INT < VERSION_CODES.Q) {
        val saveDirectory =
            File(
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                "PixivFunc"
            )

        return saveDirectory.exists() && File("${saveDirectory.absolutePath}/$filename").exists()
    }

    val where =
        "${MediaStore.Images.Media.RELATIVE_PATH} LIKE ? AND ${MediaStore.Images.Media.DISPLAY_NAME} = ?"

    val args = arrayOf(
        "%${Environment.DIRECTORY_PICTURES}/${"PixivFunc"}%",
        filename,
    )

    contentResolver.query(
        MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
        arrayOf(MediaStore.Images.Media._ID),
        where,
        args,
        //不排序
        null
    )?.use { cursor ->
        if (cursor.moveToNext()) {
            return true
        }
    }

    return false
}

class DownloadManagerUtil(private val context: Context) {

    private val downloadManager: DownloadManager
        get() =
            context.getSystemService(Context.DOWNLOAD_SERVICE) as DownloadManager

    /**
     * 可能会出错Cannot update URI: content://downloads/my_downloads/-1
     * 检查下载管理器是否被禁用
     *
     * @return true
     */
    fun checkDownloadManagerEnable(): Boolean {
        try {
            // 获取下载管理器的状态
            val state: Int =
                context.packageManager.getApplicationEnabledSetting(context.packageName)
            if (state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED ||
                state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED_USER ||
                state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED_UNTIL_USED
            ) {
                // 跳转系统设置
                try {
                    val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                    intent.data = Uri.parse("package:${context.packageName}")
                    context.startActivity(intent)
                } catch (e: ActivityNotFoundException) {
                    val intent = Intent(Settings.ACTION_MANAGE_APPLICATIONS_SETTINGS)
                    context.startActivity(intent)
                }
                return false
            }
        } catch (e: Exception) {
            return false
        }
        return true
    }

    fun download(url: String, versionTag: String) {
        Log.i("Download", url)
        val destFile = File(
            Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS),
            "Chat-Box-$versionTag.apk"
        )
        if (destFile.exists()) {
            install(destFile)
            Log.i("Download", "文件已经存在")
            return
        }
        // 返回任务ID

        downloadId = try {
            downloadManager.enqueue(
                DownloadManager.Request(Uri.parse(url)).apply {
                    // 设置允许使用的网络类型
                    setAllowedNetworkTypes(
                        DownloadManager.Request.NETWORK_MOBILE or
                                DownloadManager.Request.NETWORK_WIFI
                    )
                    // 下载中以及下载完成都显示通知栏
                    setNotificationVisibility(
                        DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED
                    )

                    setTitle("Chat Box更新")
                    setDescription("正在下载${destFile.name}")
                    setMimeType("application/vnd.android.package-archive")

                    setDestinationUri(Uri.fromFile(destFile))

                }
            )
        } catch (e: Exception) {
            e.printStackTrace()
            -1
        }
        Log.i("Download", downloadId.toString())
        Log.i("Download", destFile.absolutePath)
    }

    fun install(id: Long) {
        val downloadFileUri = downloadManager.getUriForDownloadedFile(id)

        startInstall(
            if (VERSION.SDK_INT >= VERSION_CODES.N) {
                FileProvider.getUriForFile(
                    context.applicationContext,
                    context.packageName.toString() + ".FileProvider",
                    File(URI(downloadFileUri.toString()))
                )

            } else {
                downloadFileUri
            }
        )
    }

    private fun install(file: File) {
        startInstall(
            if (VERSION.SDK_INT >= VERSION_CODES.N) {
                FileProvider.getUriForFile(
                    context.applicationContext,
                    context.packageName.toString() + ".FileProvider",
                    file
                )

            } else {
                Uri.fromFile(file)
            }
        )
    }

    @SuppressLint("QueryPermissionsNeeded")
    private fun startInstall(uri: Uri) {
        Intent(Intent.ACTION_VIEW).apply {

            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

            // 7.0 以上
            if (VERSION.SDK_INT >= VERSION_CODES.N) {
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            setDataAndType(
                uri,
                "application/vnd.android.package-archive"
            )

        }.run {
            if (resolveActivity(context.packageManager) != null) {
                try {
                    context.startActivity(this)
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }


    companion object {

        var downloadId: Long = 0L
    }
}

class DownloadReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {

        if (intent.action == DownloadManager.ACTION_DOWNLOAD_COMPLETE) {
            intent.getLongExtra(
                DownloadManager.EXTRA_DOWNLOAD_ID,
                -1
            ).let {
                if (it == DownloadManagerUtil.downloadId) {
                    DownloadManagerUtil(context).run {
                        install(it)
                    }
                }
            }

        }

    }
}

class PlatformApi(private val context: Context) {
    val pluginName = "xhzq/platform/api"

    fun toast(content: String, isLong: Boolean) {
        Toast.makeText(
            context,
            content,
            if (isLong)
                Toast.LENGTH_LONG
            else
                Toast.LENGTH_SHORT,
        ).show()
    }

    fun getBuildVersion(): Int {
        return VERSION.SDK_INT
    }

    fun getAppVersion(): String {
        return context.packageManager.getPackageInfo(
            context.packageName,
            0
        ).versionName
    }

    fun updateApp(url: String, versionTag: String): Boolean {
        return DownloadManagerUtil(context).run {
            checkDownloadManagerEnable().also {
                if (it) {
                    download(url, versionTag)
                } else {
                    Log.i("PlatformApi", "下载管理器被禁用")
                }
            }
        }
    }

    fun urlLaunch(url: String): Boolean {
        return try {
            context.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
            true
        } catch (e: Exception) {
            false
        }
    }

    fun saveImage(imageBytes: ByteArray, filename: String): Boolean? {
        return context.saveImage(imageBytes, filename)
    }

    enum class Method(val value: String) {
        TOAST("toast"),
        GET_BUILD_VERSION("getBuildVersion"),
        GET_APP_VERSION("getAppVersion"),
        URL_LAUNCH("urlLaunch"),
        UPDATE_APP("updateApp"),
        NOTIFICATION("notification"),
        SAVE_IMAGE("saveImage"),
    }
}

private const val CHANNEL_ID = "cb_0"
private const val PAYLOAD = "payload"
private const val SELECT_NOTIFICATION = "SELECT_NOTIFICATION"

class PlatformApiPlugin(private val context: Context) : FlutterPlugin, NewIntentListener, ActivityAware {

    private val api = PlatformApi(context)
    private lateinit var channel: MethodChannel


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            binding.binaryMessenger,
            api.pluginName
        ).also {
            it.setMethodCallHandler { call, result ->
                when (call.method) {
                    PlatformApi.Method.TOAST.value -> {
                        api.toast(
                            call.argument<String>("content")!!,
                            call.argument<Boolean>("isLong")!!
                        )
                        result.success(true)
                    }
                    PlatformApi.Method.GET_BUILD_VERSION.value -> {
                        result.success(api.getBuildVersion())
                    }
                    PlatformApi.Method.GET_APP_VERSION.value -> {
                        result.success(api.getAppVersion())
                    }
                    PlatformApi.Method.URL_LAUNCH.value -> {
                        result.success(api.urlLaunch(call.argument<String>("url")!!))
                    }
                    PlatformApi.Method.UPDATE_APP.value -> {
                        result.success(
                            api.updateApp(
                                call.argument<String>("url")!!,
                                call.argument<String>("versionTag")!!,
                            )
                        )
                    }
                    PlatformApi.Method.NOTIFICATION.value -> {
                        result.success(
                            handleNotification(
                                call.argument<Int>("id")!!,
                                call.argument<String>("title")!!,
                                call.argument<String>("body")!!,
                                call.argument<String>("payload")!!
                            )
                        )
                    }
                    PlatformApi.Method.SAVE_IMAGE.value -> {
                        thread {
                            val rs = api.saveImage(
                                call.argument<ByteArray>("imageBytes")!!,
                                call.argument<String>("filename")!!
                            )
                            Handler(Looper.getMainLooper()).post {
                                result.success(rs)
                            }
                        }
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }
        }
    }

    private fun openNotificationSettingsForApp(context: Context) {
        // Links to this app's notification settings.
        val intent = Intent()
        intent.action = "android.settings.APP_NOTIFICATION_SETTINGS"
        intent.putExtra("app_package", context.packageName)
        intent.putExtra("app_uid", context.applicationInfo.uid)
        // for Android 8 and above
        intent.putExtra("android.provider.extra.APP_PACKAGE", context.packageName)
        context.startActivity(intent)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}

    private fun isNotificationChannelEnabled(context: Context): Boolean {
        return if (VERSION.SDK_INT >= VERSION_CODES.O) {
            if (!TextUtils.isEmpty(CHANNEL_ID)) {
                val manager = NotificationManagerCompat.from(context)
                val channel = manager.getNotificationChannel(CHANNEL_ID)
                return if (channel != null) {
                    channel.importance != NotificationManager.IMPORTANCE_NONE
                } else {
                    false
                }
            }
            false
        } else {
            NotificationManagerCompat.from(context).areNotificationsEnabled()
        }
    }

    private fun createNotificationChannel() {
        if (VERSION.SDK_INT >= VERSION_CODES.O) {
            val name = "xhzq_cb"
            val descriptionText = "CB Message Channel"
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(CHANNEL_ID, name, importance).apply {
                description = descriptionText
                setShowBadge(true)
                if (VERSION.SDK_INT >= VERSION_CODES.Q) {
                    setAllowBubbles(true)
                }
                setImportance(NotificationManager.IMPORTANCE_HIGH)
            }
            NotificationManagerCompat.from(context).createNotificationChannel(channel)
        }

        if (!isNotificationChannelEnabled(context)) {
            api.toast("Notification not Enabled", true)
            openNotificationSettingsForApp(context)
        }
    }

    override fun onNewIntent(intent: Intent): Boolean {
        msgNumber = 0 //清零
        val res = sendNotificationPayloadMessage(intent)
        if (res && mainActivity != null) {
            mainActivity!!.intent = intent
        }
        return res
    }

    private var mainActivity: Activity? = null
    private var launchIntent: Intent? = null

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)
        mainActivity = binding.activity
        launchIntent = mainActivity!!.intent
        createNotificationChannel()//attached 时创建 channel
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mainActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        binding.addOnNewIntentListener(this)
        mainActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        mainActivity = null
    }

    private fun getLaunchIntent(context: Context): Intent {
        val packageName = context.packageName
        val packageManager = context.packageManager
        return packageManager.getLaunchIntentForPackage(packageName)!!
    }

    private fun sendNotificationPayloadMessage(intent: Intent): Boolean {
        if (SELECT_NOTIFICATION == intent.action) {
            val payload = intent.getStringExtra(PAYLOAD)
            channel.invokeMethod("selectNotification", payload)
            return true
        }
        return false
    }


    private fun handleNotification(id: Int, title: String, body: String, payload: String): Boolean {
        val manager = NotificationManagerCompat.from(context)

        //intent
        val intent = getLaunchIntent(context)
        intent.action = SELECT_NOTIFICATION
        intent.putExtra(PAYLOAD, payload)
        var flags = PendingIntent.FLAG_UPDATE_CURRENT
        if (VERSION.SDK_INT >= VERSION_CODES.M) {
            flags = flags or PendingIntent.FLAG_IMMUTABLE
        }
        val pendingIntent = PendingIntent.getActivity(context, id, intent, flags)

//        manager.cancelAll()

        // Create an explicit intent for an Activity in your app
        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("CB (${++msgNumber} messages new)")
            .setFullScreenIntent(pendingIntent, true)
            .setContentIntent(pendingIntent)
            .setNumber(msgNumber)
            .setAutoCancel(true)
            .setContentText("$title $body")
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)

        val notification = builder.build()
        manager.notify(id, notification)
        return true
    }
}

private var msgNumber: Int = 0

class MainActivity : FlutterActivity() {

    override fun onResume() {
        msgNumber = 0 // 切回主activity, 消息清零
        NotificationManagerCompat.from(context).cancelAll()
        super.onResume()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(PlatformApiPlugin(context))
        super.configureFlutterEngine(flutterEngine)
    }

    override fun onDestroy() {
        super.onDestroy()
    }

    override fun onSaveInstanceState(outState: Bundle, outPersistentState: PersistableBundle) {
        super.onSaveInstanceState(outState, outPersistentState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        super.onRestoreInstanceState(savedInstanceState)
    }

}
