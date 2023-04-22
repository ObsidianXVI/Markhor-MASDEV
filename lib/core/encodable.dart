part of markhor;

abstract class Encodable {
  int get encoded;
}

abstract class OneHotEncodable extends Encodable {}

abstract class LabelEncodable extends Encodable {}

abstract class HashEncodable extends Encodable {
  @override
  int get encoded => hashCode;
}
