part of '../home_view.dart';

class _HomeTitle extends StatelessWidget {
  const _HomeTitle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: context.appColors.cardShadow,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Text(
          LocaleKeys.appTitle.tr(),
          style: TextStyle(
            color: context.colorScheme.primary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
