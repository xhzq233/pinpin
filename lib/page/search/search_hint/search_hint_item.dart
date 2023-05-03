import 'package:flutter/material.dart';
import 'package:pinpin/app/theme/app_theme.dart';
import 'package:pinpin/page/search/search_hint/model/search_hint_highlight_entity.dart';

class SearchHintItem extends StatelessWidget {
  final List<SearchHighlightEntity>? hint;
  final Function()? onTap;

  const SearchHintItem({Key? key, this.hint, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color(0xFFF5F7FC),
          ),
        ),
      ),
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap ?? (){},
            child: Text.rich(
              TextSpan(
                  children: hint
                          ?.map((e) => TextSpan(
                              text: e.text,
                              style: e.highlight
                                  ? AppTheme.headline8.copyWith(color: AppTheme.gray0)
                                  : AppTheme.headline8
                                      .copyWith(color: AppTheme.gray50)))
                          .toList() ??
                      []),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
