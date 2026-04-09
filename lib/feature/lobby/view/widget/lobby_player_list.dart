part of '../lobby_view.dart';

final List<IconData> _animalIcons = [
  FontAwesomeIcons.cat,
  FontAwesomeIcons.dog,
  FontAwesomeIcons.dove,
  FontAwesomeIcons.fish,
  FontAwesomeIcons.hippo,
  FontAwesomeIcons.horse,
  FontAwesomeIcons.spider,
  FontAwesomeIcons.frog,
  FontAwesomeIcons.dragon,
  FontAwesomeIcons.kiwiBird,
  FontAwesomeIcons.otter,
  FontAwesomeIcons.paw,
];

class _PlayerList extends StatelessWidget {

  const _PlayerList({required this.players});
  final List<String> players;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final isLeaderPlayer = index == 0;
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: ListTile(
            leading: FaIcon(
              isLeaderPlayer
                  ? FontAwesomeIcons.crown
                  : _animalIcons[index % _animalIcons.length],
              color: isLeaderPlayer ? context.appColors.goldColor : null,
              size: 32,
            ),
            title: Text(
              players[index],
              style: TextStyle(
                  fontWeight:
                      isLeaderPlayer ? FontWeight.bold : FontWeight.normal,),
            ),
            trailing: isLeaderPlayer
                ? Icon(Icons.star, color: context.appColors.goldColor)
                : null,
          ),
        );
      },
    );
  }
}
