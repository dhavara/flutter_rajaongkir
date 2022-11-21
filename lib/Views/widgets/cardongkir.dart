part of 'widgets.dart';

class CardOngkir extends StatefulWidget {
  final Costs costs;
  const CardOngkir(this.costs);

  @override
  _CardOngkirState createState() => _CardOngkirState();
}

class _CardOngkirState extends State<CardOngkir> {
  @override
  Widget build(BuildContext context) {
    Costs c = widget.costs;
    return Card(
        color: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2,
        child: InkWell(
          onTap: () {},
          splashColor: const Color(0xFF43A7FF),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            leading: const CircleAvatar(
              child: Text(
                  "R",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            title: Text("${c.description} (${c.service})",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  "Biaya: ${Helper.toIdr(c.cost!.elementAt(0).value)}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Estimasi sampai: ${c.cost!.elementAt(0).etd}",
                  style: const TextStyle(fontSize: 12, color: Colors.green),
                )
              ],
            ),
          ),
        ));
  }
}