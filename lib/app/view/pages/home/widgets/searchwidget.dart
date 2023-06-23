import 'package:flutter/material.dart';

import '../../../../utils/constants/color_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: "Search dishes,restaurants",
      trailing: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.tune))
      ],
      padding: const MaterialStatePropertyAll(
          EdgeInsets.only(left: 15, right: 15)),
      leading: Icon(
        Icons.search_outlined,
        color: kGreylight,
      ),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18))),
      backgroundColor:
          MaterialStatePropertyAll(kGreylight.withOpacity(0.2)),
      elevation: const MaterialStatePropertyAll(0),
    );
  }
}