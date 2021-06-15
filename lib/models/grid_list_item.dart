class GridListModel {
  List _gridList =
      List.generate(200, (index) => index); // 200 grid for tiles movement

  int get gridLenght {
    return _gridList.length;
  }
}
