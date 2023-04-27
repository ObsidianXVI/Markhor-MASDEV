part of markhor;

enum DataCellEvent {
  read,
  update,
}

typedef DataCellCallback<T> = void Function(T);

/// A [DataCell] is a container for a single block of data (i.e. for a single variable)
abstract class DataCell<T> {
  T _data;
  final Map<DataCellEvent, DataCellCallback<T>> hooks = {};

  DataCell(this._data);

  int size();

  void addHook(DataCellEvent event, DataCellCallback<T> callback) =>
      hooks.addAll({event: callback});

  T get data {
    hooks.entries
        .where((entry) => entry.key == DataCellEvent.read)
        .map((e) => e.value(_data));
    return _data;
  }

  T update(T newData) {
    _data = newData;
    hooks.entries
        .where((entry) => entry.key == DataCellEvent.update)
        .map((e) => e.value(newData));
    return newData;
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
