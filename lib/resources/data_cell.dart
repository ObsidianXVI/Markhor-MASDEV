part of markhor;

/// A [DataCell] is a container for a single block of data (i.e. for a single variable)
abstract class DataCell<T> {
  final T _data;

  DataCell(this._data);

  int size();

  T get data {
    return _data;
  }

  // void set(T data) {}
}

class MapCell<K, V> extends DataCell<Map<K, V>> {
  MapCell(Map<K, V> map) : super(map);

  @override
  int size() {
    return data.keys.length;
  }
}

class ListCell<E> extends DataCell<List<E>> {
  ListCell(List<E> list) : super(list);

  @override
  int size() {
    return data.length;
  }
}

class DoubleCell extends DataCell<double> {
  DoubleCell(double value) : super(value);

  @override
  int size() {
    return 1;
  }
}
