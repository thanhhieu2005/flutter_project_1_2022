class ExampleModel {
  String prop1;
  int prop2;

//<editor-fold desc="Data Methods">

  ExampleModel({
    required this.prop1,
    required this.prop2,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExampleModel &&
          runtimeType == other.runtimeType &&
          prop1 == other.prop1 &&
          prop2 == other.prop2);

  @override
  int get hashCode => prop1.hashCode ^ prop2.hashCode;

  @override
  String toString() {
    return 'ExampleModel{' + ' prop1: $prop1,' + ' prop2: $prop2,' + '}';
  }

  ExampleModel copyWith({
    String? prop1,
    int? prop2,
  }) {
    return ExampleModel(
      prop1: prop1 ?? this.prop1,
      prop2: prop2 ?? this.prop2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prop1': prop1,
      'prop2': prop2,
    };
  }

  factory ExampleModel.fromMap(Map<String, dynamic> map) {
    return ExampleModel(
      prop1: map['prop1'] as String,
      prop2: map['prop2'] as int,
    );
  }

//</editor-fold>
}
