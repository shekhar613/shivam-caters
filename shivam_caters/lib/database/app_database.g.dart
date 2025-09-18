// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DishesTable extends Dishes with TableInfo<$DishesTable, Dishe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DishesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _portionSizeMeta = const VerificationMeta(
    'portionSize',
  );
  @override
  late final GeneratedColumn<String> portionSize = GeneratedColumn<String>(
    'portion_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prepTimeMeta = const VerificationMeta(
    'prepTime',
  );
  @override
  late final GeneratedColumn<String> prepTime = GeneratedColumn<String>(
    'prep_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAvailableMeta = const VerificationMeta(
    'isAvailable',
  );
  @override
  late final GeneratedColumn<bool> isAvailable = GeneratedColumn<bool>(
    'is_available',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_available" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    category,
    price,
    portionSize,
    prepTime,
    isAvailable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dishes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dishe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('portion_size')) {
      context.handle(
        _portionSizeMeta,
        portionSize.isAcceptableOrUnknown(
          data['portion_size']!,
          _portionSizeMeta,
        ),
      );
    }
    if (data.containsKey('prep_time')) {
      context.handle(
        _prepTimeMeta,
        prepTime.isAcceptableOrUnknown(data['prep_time']!, _prepTimeMeta),
      );
    }
    if (data.containsKey('is_available')) {
      context.handle(
        _isAvailableMeta,
        isAvailable.isAcceptableOrUnknown(
          data['is_available']!,
          _isAvailableMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dishe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dishe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      portionSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portion_size'],
      ),
      prepTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prep_time'],
      ),
      isAvailable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_available'],
      )!,
    );
  }

  @override
  $DishesTable createAlias(String alias) {
    return $DishesTable(attachedDatabase, alias);
  }
}

class Dishe extends DataClass implements Insertable<Dishe> {
  final int id;
  final String name;
  final String? description;
  final String? category;
  final double price;
  final String? portionSize;
  final String? prepTime;
  final bool isAvailable;
  const Dishe({
    required this.id,
    required this.name,
    this.description,
    this.category,
    required this.price,
    this.portionSize,
    this.prepTime,
    required this.isAvailable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || portionSize != null) {
      map['portion_size'] = Variable<String>(portionSize);
    }
    if (!nullToAbsent || prepTime != null) {
      map['prep_time'] = Variable<String>(prepTime);
    }
    map['is_available'] = Variable<bool>(isAvailable);
    return map;
  }

  DishesCompanion toCompanion(bool nullToAbsent) {
    return DishesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      price: Value(price),
      portionSize: portionSize == null && nullToAbsent
          ? const Value.absent()
          : Value(portionSize),
      prepTime: prepTime == null && nullToAbsent
          ? const Value.absent()
          : Value(prepTime),
      isAvailable: Value(isAvailable),
    );
  }

  factory Dishe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dishe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String?>(json['category']),
      price: serializer.fromJson<double>(json['price']),
      portionSize: serializer.fromJson<String?>(json['portionSize']),
      prepTime: serializer.fromJson<String?>(json['prepTime']),
      isAvailable: serializer.fromJson<bool>(json['isAvailable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String?>(category),
      'price': serializer.toJson<double>(price),
      'portionSize': serializer.toJson<String?>(portionSize),
      'prepTime': serializer.toJson<String?>(prepTime),
      'isAvailable': serializer.toJson<bool>(isAvailable),
    };
  }

  Dishe copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> category = const Value.absent(),
    double? price,
    Value<String?> portionSize = const Value.absent(),
    Value<String?> prepTime = const Value.absent(),
    bool? isAvailable,
  }) => Dishe(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    category: category.present ? category.value : this.category,
    price: price ?? this.price,
    portionSize: portionSize.present ? portionSize.value : this.portionSize,
    prepTime: prepTime.present ? prepTime.value : this.prepTime,
    isAvailable: isAvailable ?? this.isAvailable,
  );
  Dishe copyWithCompanion(DishesCompanion data) {
    return Dishe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      portionSize: data.portionSize.present
          ? data.portionSize.value
          : this.portionSize,
      prepTime: data.prepTime.present ? data.prepTime.value : this.prepTime,
      isAvailable: data.isAvailable.present
          ? data.isAvailable.value
          : this.isAvailable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dishe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('portionSize: $portionSize, ')
          ..write('prepTime: $prepTime, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    category,
    price,
    portionSize,
    prepTime,
    isAvailable,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dishe &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.price == this.price &&
          other.portionSize == this.portionSize &&
          other.prepTime == this.prepTime &&
          other.isAvailable == this.isAvailable);
}

class DishesCompanion extends UpdateCompanion<Dishe> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> category;
  final Value<double> price;
  final Value<String?> portionSize;
  final Value<String?> prepTime;
  final Value<bool> isAvailable;
  const DishesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.portionSize = const Value.absent(),
    this.prepTime = const Value.absent(),
    this.isAvailable = const Value.absent(),
  });
  DishesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    required double price,
    this.portionSize = const Value.absent(),
    this.prepTime = const Value.absent(),
    this.isAvailable = const Value.absent(),
  }) : name = Value(name),
       price = Value(price);
  static Insertable<Dishe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<double>? price,
    Expression<String>? portionSize,
    Expression<String>? prepTime,
    Expression<bool>? isAvailable,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (portionSize != null) 'portion_size': portionSize,
      if (prepTime != null) 'prep_time': prepTime,
      if (isAvailable != null) 'is_available': isAvailable,
    });
  }

  DishesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? category,
    Value<double>? price,
    Value<String?>? portionSize,
    Value<String?>? prepTime,
    Value<bool>? isAvailable,
  }) {
    return DishesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      portionSize: portionSize ?? this.portionSize,
      prepTime: prepTime ?? this.prepTime,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (portionSize.present) {
      map['portion_size'] = Variable<String>(portionSize.value);
    }
    if (prepTime.present) {
      map['prep_time'] = Variable<String>(prepTime.value);
    }
    if (isAvailable.present) {
      map['is_available'] = Variable<bool>(isAvailable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DishesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('portionSize: $portionSize, ')
          ..write('prepTime: $prepTime, ')
          ..write('isAvailable: $isAvailable')
          ..write(')'))
        .toString();
  }
}

class $StocksTable extends Stocks with TableInfo<$StocksTable, Stock> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _availableQuantityMeta = const VerificationMeta(
    'availableQuantity',
  );
  @override
  late final GeneratedColumn<double> availableQuantity =
      GeneratedColumn<double>(
        'available_quantity',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _minQuantityMeta = const VerificationMeta(
    'minQuantity',
  );
  @override
  late final GeneratedColumn<double> minQuantity = GeneratedColumn<double>(
    'min_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    availableQuantity,
    minQuantity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stocks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Stock> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('available_quantity')) {
      context.handle(
        _availableQuantityMeta,
        availableQuantity.isAcceptableOrUnknown(
          data['available_quantity']!,
          _availableQuantityMeta,
        ),
      );
    }
    if (data.containsKey('min_quantity')) {
      context.handle(
        _minQuantityMeta,
        minQuantity.isAcceptableOrUnknown(
          data['min_quantity']!,
          _minQuantityMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Stock map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Stock(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      availableQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}available_quantity'],
      )!,
      minQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_quantity'],
      )!,
    );
  }

  @override
  $StocksTable createAlias(String alias) {
    return $StocksTable(attachedDatabase, alias);
  }
}

class Stock extends DataClass implements Insertable<Stock> {
  final int id;
  final String name;
  final String? category;
  final double availableQuantity;
  final double minQuantity;
  const Stock({
    required this.id,
    required this.name,
    this.category,
    required this.availableQuantity,
    required this.minQuantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['available_quantity'] = Variable<double>(availableQuantity);
    map['min_quantity'] = Variable<double>(minQuantity);
    return map;
  }

  StocksCompanion toCompanion(bool nullToAbsent) {
    return StocksCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      availableQuantity: Value(availableQuantity),
      minQuantity: Value(minQuantity),
    );
  }

  factory Stock.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Stock(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      availableQuantity: serializer.fromJson<double>(json['availableQuantity']),
      minQuantity: serializer.fromJson<double>(json['minQuantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'availableQuantity': serializer.toJson<double>(availableQuantity),
      'minQuantity': serializer.toJson<double>(minQuantity),
    };
  }

  Stock copyWith({
    int? id,
    String? name,
    Value<String?> category = const Value.absent(),
    double? availableQuantity,
    double? minQuantity,
  }) => Stock(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    availableQuantity: availableQuantity ?? this.availableQuantity,
    minQuantity: minQuantity ?? this.minQuantity,
  );
  Stock copyWithCompanion(StocksCompanion data) {
    return Stock(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      availableQuantity: data.availableQuantity.present
          ? data.availableQuantity.value
          : this.availableQuantity,
      minQuantity: data.minQuantity.present
          ? data.minQuantity.value
          : this.minQuantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Stock(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('minQuantity: $minQuantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, category, availableQuantity, minQuantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Stock &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.availableQuantity == this.availableQuantity &&
          other.minQuantity == this.minQuantity);
}

class StocksCompanion extends UpdateCompanion<Stock> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<double> availableQuantity;
  final Value<double> minQuantity;
  const StocksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.minQuantity = const Value.absent(),
  });
  StocksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.category = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.minQuantity = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Stock> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? availableQuantity,
    Expression<double>? minQuantity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (availableQuantity != null) 'available_quantity': availableQuantity,
      if (minQuantity != null) 'min_quantity': minQuantity,
    });
  }

  StocksCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? category,
    Value<double>? availableQuantity,
    Value<double>? minQuantity,
  }) {
    return StocksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      minQuantity: minQuantity ?? this.minQuantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (availableQuantity.present) {
      map['available_quantity'] = Variable<double>(availableQuantity.value);
    }
    if (minQuantity.present) {
      map['min_quantity'] = Variable<double>(minQuantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StocksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('minQuantity: $minQuantity')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contactNumberMeta = const VerificationMeta(
    'contactNumber',
  );
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
    'contact_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventNameMeta = const VerificationMeta(
    'eventName',
  );
  @override
  late final GeneratedColumn<String> eventName = GeneratedColumn<String>(
    'event_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventDateMeta = const VerificationMeta(
    'eventDate',
  );
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
    'event_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookingDateMeta = const VerificationMeta(
    'bookingDate',
  );
  @override
  late final GeneratedColumn<DateTime> bookingDate = GeneratedColumn<DateTime>(
    'booking_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventPlaceMeta = const VerificationMeta(
    'eventPlace',
  );
  @override
  late final GeneratedColumn<String> eventPlace = GeneratedColumn<String>(
    'event_place',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _decorationItemsMeta = const VerificationMeta(
    'decorationItems',
  );
  @override
  late final GeneratedColumn<String> decorationItems = GeneratedColumn<String>(
    'decoration_items',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: Constant(0.0),
  );
  static const VerificationMeta _advancePaymentMeta = const VerificationMeta(
    'advancePayment',
  );
  @override
  late final GeneratedColumn<double> advancePayment = GeneratedColumn<double>(
    'advance_payment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: Constant(0.0),
  );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerName,
    contactNumber,
    eventName,
    eventDate,
    bookingDate,
    eventPlace,
    decorationItems,
    totalAmount,
    advancePayment,
    paymentMode,
    notes,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('contact_number')) {
      context.handle(
        _contactNumberMeta,
        contactNumber.isAcceptableOrUnknown(
          data['contact_number']!,
          _contactNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactNumberMeta);
    }
    if (data.containsKey('event_name')) {
      context.handle(
        _eventNameMeta,
        eventName.isAcceptableOrUnknown(data['event_name']!, _eventNameMeta),
      );
    } else if (isInserting) {
      context.missing(_eventNameMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(
        _eventDateMeta,
        eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta),
      );
    } else if (isInserting) {
      context.missing(_eventDateMeta);
    }
    if (data.containsKey('booking_date')) {
      context.handle(
        _bookingDateMeta,
        bookingDate.isAcceptableOrUnknown(
          data['booking_date']!,
          _bookingDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bookingDateMeta);
    }
    if (data.containsKey('event_place')) {
      context.handle(
        _eventPlaceMeta,
        eventPlace.isAcceptableOrUnknown(data['event_place']!, _eventPlaceMeta),
      );
    } else if (isInserting) {
      context.missing(_eventPlaceMeta);
    }
    if (data.containsKey('decoration_items')) {
      context.handle(
        _decorationItemsMeta,
        decorationItems.isAcceptableOrUnknown(
          data['decoration_items']!,
          _decorationItemsMeta,
        ),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('advance_payment')) {
      context.handle(
        _advancePaymentMeta,
        advancePayment.isAcceptableOrUnknown(
          data['advance_payment']!,
          _advancePaymentMeta,
        ),
      );
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      contactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_number'],
      )!,
      eventName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_name'],
      )!,
      eventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_date'],
      )!,
      bookingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}booking_date'],
      )!,
      eventPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_place'],
      )!,
      decorationItems: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}decoration_items'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      advancePayment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}advance_payment'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final String customerName;
  final String contactNumber;
  final String eventName;
  final DateTime eventDate;
  final DateTime bookingDate;
  final String eventPlace;
  final String? decorationItems;
  final double totalAmount;
  final double advancePayment;
  final String? paymentMode;
  final String? notes;
  final String status;
  const Order({
    required this.id,
    required this.customerName,
    required this.contactNumber,
    required this.eventName,
    required this.eventDate,
    required this.bookingDate,
    required this.eventPlace,
    this.decorationItems,
    required this.totalAmount,
    required this.advancePayment,
    this.paymentMode,
    this.notes,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_name'] = Variable<String>(customerName);
    map['contact_number'] = Variable<String>(contactNumber);
    map['event_name'] = Variable<String>(eventName);
    map['event_date'] = Variable<DateTime>(eventDate);
    map['booking_date'] = Variable<DateTime>(bookingDate);
    map['event_place'] = Variable<String>(eventPlace);
    if (!nullToAbsent || decorationItems != null) {
      map['decoration_items'] = Variable<String>(decorationItems);
    }
    map['total_amount'] = Variable<double>(totalAmount);
    map['advance_payment'] = Variable<double>(advancePayment);
    if (!nullToAbsent || paymentMode != null) {
      map['payment_mode'] = Variable<String>(paymentMode);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      customerName: Value(customerName),
      contactNumber: Value(contactNumber),
      eventName: Value(eventName),
      eventDate: Value(eventDate),
      bookingDate: Value(bookingDate),
      eventPlace: Value(eventPlace),
      decorationItems: decorationItems == null && nullToAbsent
          ? const Value.absent()
          : Value(decorationItems),
      totalAmount: Value(totalAmount),
      advancePayment: Value(advancePayment),
      paymentMode: paymentMode == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMode),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      customerName: serializer.fromJson<String>(json['customerName']),
      contactNumber: serializer.fromJson<String>(json['contactNumber']),
      eventName: serializer.fromJson<String>(json['eventName']),
      eventDate: serializer.fromJson<DateTime>(json['eventDate']),
      bookingDate: serializer.fromJson<DateTime>(json['bookingDate']),
      eventPlace: serializer.fromJson<String>(json['eventPlace']),
      decorationItems: serializer.fromJson<String?>(json['decorationItems']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      advancePayment: serializer.fromJson<double>(json['advancePayment']),
      paymentMode: serializer.fromJson<String?>(json['paymentMode']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerName': serializer.toJson<String>(customerName),
      'contactNumber': serializer.toJson<String>(contactNumber),
      'eventName': serializer.toJson<String>(eventName),
      'eventDate': serializer.toJson<DateTime>(eventDate),
      'bookingDate': serializer.toJson<DateTime>(bookingDate),
      'eventPlace': serializer.toJson<String>(eventPlace),
      'decorationItems': serializer.toJson<String?>(decorationItems),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'advancePayment': serializer.toJson<double>(advancePayment),
      'paymentMode': serializer.toJson<String?>(paymentMode),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
    };
  }

  Order copyWith({
    int? id,
    String? customerName,
    String? contactNumber,
    String? eventName,
    DateTime? eventDate,
    DateTime? bookingDate,
    String? eventPlace,
    Value<String?> decorationItems = const Value.absent(),
    double? totalAmount,
    double? advancePayment,
    Value<String?> paymentMode = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? status,
  }) => Order(
    id: id ?? this.id,
    customerName: customerName ?? this.customerName,
    contactNumber: contactNumber ?? this.contactNumber,
    eventName: eventName ?? this.eventName,
    eventDate: eventDate ?? this.eventDate,
    bookingDate: bookingDate ?? this.bookingDate,
    eventPlace: eventPlace ?? this.eventPlace,
    decorationItems: decorationItems.present
        ? decorationItems.value
        : this.decorationItems,
    totalAmount: totalAmount ?? this.totalAmount,
    advancePayment: advancePayment ?? this.advancePayment,
    paymentMode: paymentMode.present ? paymentMode.value : this.paymentMode,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      eventName: data.eventName.present ? data.eventName.value : this.eventName,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      bookingDate: data.bookingDate.present
          ? data.bookingDate.value
          : this.bookingDate,
      eventPlace: data.eventPlace.present
          ? data.eventPlace.value
          : this.eventPlace,
      decorationItems: data.decorationItems.present
          ? data.decorationItems.value
          : this.decorationItems,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      advancePayment: data.advancePayment.present
          ? data.advancePayment.value
          : this.advancePayment,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('eventName: $eventName, ')
          ..write('eventDate: $eventDate, ')
          ..write('bookingDate: $bookingDate, ')
          ..write('eventPlace: $eventPlace, ')
          ..write('decorationItems: $decorationItems, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('advancePayment: $advancePayment, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerName,
    contactNumber,
    eventName,
    eventDate,
    bookingDate,
    eventPlace,
    decorationItems,
    totalAmount,
    advancePayment,
    paymentMode,
    notes,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.customerName == this.customerName &&
          other.contactNumber == this.contactNumber &&
          other.eventName == this.eventName &&
          other.eventDate == this.eventDate &&
          other.bookingDate == this.bookingDate &&
          other.eventPlace == this.eventPlace &&
          other.decorationItems == this.decorationItems &&
          other.totalAmount == this.totalAmount &&
          other.advancePayment == this.advancePayment &&
          other.paymentMode == this.paymentMode &&
          other.notes == this.notes &&
          other.status == this.status);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<String> customerName;
  final Value<String> contactNumber;
  final Value<String> eventName;
  final Value<DateTime> eventDate;
  final Value<DateTime> bookingDate;
  final Value<String> eventPlace;
  final Value<String?> decorationItems;
  final Value<double> totalAmount;
  final Value<double> advancePayment;
  final Value<String?> paymentMode;
  final Value<String?> notes;
  final Value<String> status;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.customerName = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.eventName = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.bookingDate = const Value.absent(),
    this.eventPlace = const Value.absent(),
    this.decorationItems = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.advancePayment = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    required String customerName,
    required String contactNumber,
    required String eventName,
    required DateTime eventDate,
    required DateTime bookingDate,
    required String eventPlace,
    this.decorationItems = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.advancePayment = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.notes = const Value.absent(),
    required String status,
  }) : customerName = Value(customerName),
       contactNumber = Value(contactNumber),
       eventName = Value(eventName),
       eventDate = Value(eventDate),
       bookingDate = Value(bookingDate),
       eventPlace = Value(eventPlace),
       status = Value(status);
  static Insertable<Order> custom({
    Expression<int>? id,
    Expression<String>? customerName,
    Expression<String>? contactNumber,
    Expression<String>? eventName,
    Expression<DateTime>? eventDate,
    Expression<DateTime>? bookingDate,
    Expression<String>? eventPlace,
    Expression<String>? decorationItems,
    Expression<double>? totalAmount,
    Expression<double>? advancePayment,
    Expression<String>? paymentMode,
    Expression<String>? notes,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerName != null) 'customer_name': customerName,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (eventName != null) 'event_name': eventName,
      if (eventDate != null) 'event_date': eventDate,
      if (bookingDate != null) 'booking_date': bookingDate,
      if (eventPlace != null) 'event_place': eventPlace,
      if (decorationItems != null) 'decoration_items': decorationItems,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (advancePayment != null) 'advance_payment': advancePayment,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
    });
  }

  OrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? customerName,
    Value<String>? contactNumber,
    Value<String>? eventName,
    Value<DateTime>? eventDate,
    Value<DateTime>? bookingDate,
    Value<String>? eventPlace,
    Value<String?>? decorationItems,
    Value<double>? totalAmount,
    Value<double>? advancePayment,
    Value<String?>? paymentMode,
    Value<String?>? notes,
    Value<String>? status,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      contactNumber: contactNumber ?? this.contactNumber,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      bookingDate: bookingDate ?? this.bookingDate,
      eventPlace: eventPlace ?? this.eventPlace,
      decorationItems: decorationItems ?? this.decorationItems,
      totalAmount: totalAmount ?? this.totalAmount,
      advancePayment: advancePayment ?? this.advancePayment,
      paymentMode: paymentMode ?? this.paymentMode,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (eventName.present) {
      map['event_name'] = Variable<String>(eventName.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (bookingDate.present) {
      map['booking_date'] = Variable<DateTime>(bookingDate.value);
    }
    if (eventPlace.present) {
      map['event_place'] = Variable<String>(eventPlace.value);
    }
    if (decorationItems.present) {
      map['decoration_items'] = Variable<String>(decorationItems.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (advancePayment.present) {
      map['advance_payment'] = Variable<double>(advancePayment.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('eventName: $eventName, ')
          ..write('eventDate: $eventDate, ')
          ..write('bookingDate: $bookingDate, ')
          ..write('eventPlace: $eventPlace, ')
          ..write('decorationItems: $decorationItems, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('advancePayment: $advancePayment, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('notes: $notes, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $OrderMealsTable extends OrderMeals
    with TableInfo<$OrderMealsTable, OrderMeal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderMealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberOfPersonsMeta = const VerificationMeta(
    'numberOfPersons',
  );
  @override
  late final GeneratedColumn<int> numberOfPersons = GeneratedColumn<int>(
    'number_of_persons',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _extraPersonsMeta = const VerificationMeta(
    'extraPersons',
  );
  @override
  late final GeneratedColumn<int> extraPersons = GeneratedColumn<int>(
    'extra_persons',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _pricePerPersonMeta = const VerificationMeta(
    'pricePerPerson',
  );
  @override
  late final GeneratedColumn<double> pricePerPerson = GeneratedColumn<double>(
    'price_per_person',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    mealType,
    startTime,
    endTime,
    numberOfPersons,
    extraPersons,
    pricePerPerson,
    totalAmount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_meals';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderMeal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    if (data.containsKey('number_of_persons')) {
      context.handle(
        _numberOfPersonsMeta,
        numberOfPersons.isAcceptableOrUnknown(
          data['number_of_persons']!,
          _numberOfPersonsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberOfPersonsMeta);
    }
    if (data.containsKey('extra_persons')) {
      context.handle(
        _extraPersonsMeta,
        extraPersons.isAcceptableOrUnknown(
          data['extra_persons']!,
          _extraPersonsMeta,
        ),
      );
    }
    if (data.containsKey('price_per_person')) {
      context.handle(
        _pricePerPersonMeta,
        pricePerPerson.isAcceptableOrUnknown(
          data['price_per_person']!,
          _pricePerPersonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerPersonMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderMeal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderMeal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      )!,
      numberOfPersons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_of_persons'],
      )!,
      extraPersons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}extra_persons'],
      )!,
      pricePerPerson: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_person'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
    );
  }

  @override
  $OrderMealsTable createAlias(String alias) {
    return $OrderMealsTable(attachedDatabase, alias);
  }
}

class OrderMeal extends DataClass implements Insertable<OrderMeal> {
  final int id;
  final int orderId;
  final String mealType;
  final DateTime startTime;
  final DateTime endTime;
  final int numberOfPersons;
  final int extraPersons;
  final double pricePerPerson;
  final double totalAmount;
  const OrderMeal({
    required this.id,
    required this.orderId,
    required this.mealType,
    required this.startTime,
    required this.endTime,
    required this.numberOfPersons,
    required this.extraPersons,
    required this.pricePerPerson,
    required this.totalAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['meal_type'] = Variable<String>(mealType);
    map['start_time'] = Variable<DateTime>(startTime);
    map['end_time'] = Variable<DateTime>(endTime);
    map['number_of_persons'] = Variable<int>(numberOfPersons);
    map['extra_persons'] = Variable<int>(extraPersons);
    map['price_per_person'] = Variable<double>(pricePerPerson);
    map['total_amount'] = Variable<double>(totalAmount);
    return map;
  }

  OrderMealsCompanion toCompanion(bool nullToAbsent) {
    return OrderMealsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      mealType: Value(mealType),
      startTime: Value(startTime),
      endTime: Value(endTime),
      numberOfPersons: Value(numberOfPersons),
      extraPersons: Value(extraPersons),
      pricePerPerson: Value(pricePerPerson),
      totalAmount: Value(totalAmount),
    );
  }

  factory OrderMeal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderMeal(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      mealType: serializer.fromJson<String>(json['mealType']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
      numberOfPersons: serializer.fromJson<int>(json['numberOfPersons']),
      extraPersons: serializer.fromJson<int>(json['extraPersons']),
      pricePerPerson: serializer.fromJson<double>(json['pricePerPerson']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'mealType': serializer.toJson<String>(mealType),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
      'numberOfPersons': serializer.toJson<int>(numberOfPersons),
      'extraPersons': serializer.toJson<int>(extraPersons),
      'pricePerPerson': serializer.toJson<double>(pricePerPerson),
      'totalAmount': serializer.toJson<double>(totalAmount),
    };
  }

  OrderMeal copyWith({
    int? id,
    int? orderId,
    String? mealType,
    DateTime? startTime,
    DateTime? endTime,
    int? numberOfPersons,
    int? extraPersons,
    double? pricePerPerson,
    double? totalAmount,
  }) => OrderMeal(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    mealType: mealType ?? this.mealType,
    startTime: startTime ?? this.startTime,
    endTime: endTime ?? this.endTime,
    numberOfPersons: numberOfPersons ?? this.numberOfPersons,
    extraPersons: extraPersons ?? this.extraPersons,
    pricePerPerson: pricePerPerson ?? this.pricePerPerson,
    totalAmount: totalAmount ?? this.totalAmount,
  );
  OrderMeal copyWithCompanion(OrderMealsCompanion data) {
    return OrderMeal(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      numberOfPersons: data.numberOfPersons.present
          ? data.numberOfPersons.value
          : this.numberOfPersons,
      extraPersons: data.extraPersons.present
          ? data.extraPersons.value
          : this.extraPersons,
      pricePerPerson: data.pricePerPerson.present
          ? data.pricePerPerson.value
          : this.pricePerPerson,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderMeal(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('mealType: $mealType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('numberOfPersons: $numberOfPersons, ')
          ..write('extraPersons: $extraPersons, ')
          ..write('pricePerPerson: $pricePerPerson, ')
          ..write('totalAmount: $totalAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    orderId,
    mealType,
    startTime,
    endTime,
    numberOfPersons,
    extraPersons,
    pricePerPerson,
    totalAmount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderMeal &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.mealType == this.mealType &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.numberOfPersons == this.numberOfPersons &&
          other.extraPersons == this.extraPersons &&
          other.pricePerPerson == this.pricePerPerson &&
          other.totalAmount == this.totalAmount);
}

class OrderMealsCompanion extends UpdateCompanion<OrderMeal> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> mealType;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  final Value<int> numberOfPersons;
  final Value<int> extraPersons;
  final Value<double> pricePerPerson;
  final Value<double> totalAmount;
  const OrderMealsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.mealType = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.numberOfPersons = const Value.absent(),
    this.extraPersons = const Value.absent(),
    this.pricePerPerson = const Value.absent(),
    this.totalAmount = const Value.absent(),
  });
  OrderMealsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String mealType,
    required DateTime startTime,
    required DateTime endTime,
    required int numberOfPersons,
    this.extraPersons = const Value.absent(),
    required double pricePerPerson,
    required double totalAmount,
  }) : orderId = Value(orderId),
       mealType = Value(mealType),
       startTime = Value(startTime),
       endTime = Value(endTime),
       numberOfPersons = Value(numberOfPersons),
       pricePerPerson = Value(pricePerPerson),
       totalAmount = Value(totalAmount);
  static Insertable<OrderMeal> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<String>? mealType,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? numberOfPersons,
    Expression<int>? extraPersons,
    Expression<double>? pricePerPerson,
    Expression<double>? totalAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (mealType != null) 'meal_type': mealType,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (numberOfPersons != null) 'number_of_persons': numberOfPersons,
      if (extraPersons != null) 'extra_persons': extraPersons,
      if (pricePerPerson != null) 'price_per_person': pricePerPerson,
      if (totalAmount != null) 'total_amount': totalAmount,
    });
  }

  OrderMealsCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<String>? mealType,
    Value<DateTime>? startTime,
    Value<DateTime>? endTime,
    Value<int>? numberOfPersons,
    Value<int>? extraPersons,
    Value<double>? pricePerPerson,
    Value<double>? totalAmount,
  }) {
    return OrderMealsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      mealType: mealType ?? this.mealType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      numberOfPersons: numberOfPersons ?? this.numberOfPersons,
      extraPersons: extraPersons ?? this.extraPersons,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (numberOfPersons.present) {
      map['number_of_persons'] = Variable<int>(numberOfPersons.value);
    }
    if (extraPersons.present) {
      map['extra_persons'] = Variable<int>(extraPersons.value);
    }
    if (pricePerPerson.present) {
      map['price_per_person'] = Variable<double>(pricePerPerson.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderMealsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('mealType: $mealType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('numberOfPersons: $numberOfPersons, ')
          ..write('extraPersons: $extraPersons, ')
          ..write('pricePerPerson: $pricePerPerson, ')
          ..write('totalAmount: $totalAmount')
          ..write(')'))
        .toString();
  }
}

class $OrderDishesTable extends OrderDishes
    with TableInfo<$OrderDishesTable, OrderDishe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderDishesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _dishNameMeta = const VerificationMeta(
    'dishName',
  );
  @override
  late final GeneratedColumn<String> dishName = GeneratedColumn<String>(
    'dish_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(1),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    dishName,
    quantity,
    price,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_dishes';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderDishe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('dish_name')) {
      context.handle(
        _dishNameMeta,
        dishName.isAcceptableOrUnknown(data['dish_name']!, _dishNameMeta),
      );
    } else if (isInserting) {
      context.missing(_dishNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderDishe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderDishe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_id'],
      )!,
      dishName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dish_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
    );
  }

  @override
  $OrderDishesTable createAlias(String alias) {
    return $OrderDishesTable(attachedDatabase, alias);
  }
}

class OrderDishe extends DataClass implements Insertable<OrderDishe> {
  final int id;
  final int orderId;
  final String dishName;
  final int quantity;
  final double price;
  const OrderDishe({
    required this.id,
    required this.orderId,
    required this.dishName,
    required this.quantity,
    required this.price,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['dish_name'] = Variable<String>(dishName);
    map['quantity'] = Variable<int>(quantity);
    map['price'] = Variable<double>(price);
    return map;
  }

  OrderDishesCompanion toCompanion(bool nullToAbsent) {
    return OrderDishesCompanion(
      id: Value(id),
      orderId: Value(orderId),
      dishName: Value(dishName),
      quantity: Value(quantity),
      price: Value(price),
    );
  }

  factory OrderDishe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderDishe(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      dishName: serializer.fromJson<String>(json['dishName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      price: serializer.fromJson<double>(json['price']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'dishName': serializer.toJson<String>(dishName),
      'quantity': serializer.toJson<int>(quantity),
      'price': serializer.toJson<double>(price),
    };
  }

  OrderDishe copyWith({
    int? id,
    int? orderId,
    String? dishName,
    int? quantity,
    double? price,
  }) => OrderDishe(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    dishName: dishName ?? this.dishName,
    quantity: quantity ?? this.quantity,
    price: price ?? this.price,
  );
  OrderDishe copyWithCompanion(OrderDishesCompanion data) {
    return OrderDishe(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      dishName: data.dishName.present ? data.dishName.value : this.dishName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      price: data.price.present ? data.price.value : this.price,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderDishe(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('dishName: $dishName, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, dishName, quantity, price);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderDishe &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.dishName == this.dishName &&
          other.quantity == this.quantity &&
          other.price == this.price);
}

class OrderDishesCompanion extends UpdateCompanion<OrderDishe> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> dishName;
  final Value<int> quantity;
  final Value<double> price;
  const OrderDishesCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.dishName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
  });
  OrderDishesCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String dishName,
    this.quantity = const Value.absent(),
    this.price = const Value.absent(),
  }) : orderId = Value(orderId),
       dishName = Value(dishName);
  static Insertable<OrderDishe> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<String>? dishName,
    Expression<int>? quantity,
    Expression<double>? price,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (dishName != null) 'dish_name': dishName,
      if (quantity != null) 'quantity': quantity,
      if (price != null) 'price': price,
    });
  }

  OrderDishesCompanion copyWith({
    Value<int>? id,
    Value<int>? orderId,
    Value<String>? dishName,
    Value<int>? quantity,
    Value<double>? price,
  }) {
    return OrderDishesCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      dishName: dishName ?? this.dishName,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (dishName.present) {
      map['dish_name'] = Variable<String>(dishName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderDishesCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('dishName: $dishName, ')
          ..write('quantity: $quantity, ')
          ..write('price: $price')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DishesTable dishes = $DishesTable(this);
  late final $StocksTable stocks = $StocksTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderMealsTable orderMeals = $OrderMealsTable(this);
  late final $OrderDishesTable orderDishes = $OrderDishesTable(this);
  late final OrderDao orderDao = OrderDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dishes,
    stocks,
    orders,
    orderMeals,
    orderDishes,
  ];
}

typedef $$DishesTableCreateCompanionBuilder =
    DishesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<String?> category,
      required double price,
      Value<String?> portionSize,
      Value<String?> prepTime,
      Value<bool> isAvailable,
    });
typedef $$DishesTableUpdateCompanionBuilder =
    DishesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String?> category,
      Value<double> price,
      Value<String?> portionSize,
      Value<String?> prepTime,
      Value<bool> isAvailable,
    });

class $$DishesTableFilterComposer
    extends Composer<_$AppDatabase, $DishesTable> {
  $$DishesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get portionSize => $composableBuilder(
    column: $table.portionSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prepTime => $composableBuilder(
    column: $table.prepTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DishesTableOrderingComposer
    extends Composer<_$AppDatabase, $DishesTable> {
  $$DishesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get portionSize => $composableBuilder(
    column: $table.portionSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prepTime => $composableBuilder(
    column: $table.prepTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DishesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DishesTable> {
  $$DishesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get portionSize => $composableBuilder(
    column: $table.portionSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prepTime =>
      $composableBuilder(column: $table.prepTime, builder: (column) => column);

  GeneratedColumn<bool> get isAvailable => $composableBuilder(
    column: $table.isAvailable,
    builder: (column) => column,
  );
}

class $$DishesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DishesTable,
          Dishe,
          $$DishesTableFilterComposer,
          $$DishesTableOrderingComposer,
          $$DishesTableAnnotationComposer,
          $$DishesTableCreateCompanionBuilder,
          $$DishesTableUpdateCompanionBuilder,
          (Dishe, BaseReferences<_$AppDatabase, $DishesTable, Dishe>),
          Dishe,
          PrefetchHooks Function()
        > {
  $$DishesTableTableManager(_$AppDatabase db, $DishesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DishesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DishesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DishesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String?> portionSize = const Value.absent(),
                Value<String?> prepTime = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
              }) => DishesCompanion(
                id: id,
                name: name,
                description: description,
                category: category,
                price: price,
                portionSize: portionSize,
                prepTime: prepTime,
                isAvailable: isAvailable,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> category = const Value.absent(),
                required double price,
                Value<String?> portionSize = const Value.absent(),
                Value<String?> prepTime = const Value.absent(),
                Value<bool> isAvailable = const Value.absent(),
              }) => DishesCompanion.insert(
                id: id,
                name: name,
                description: description,
                category: category,
                price: price,
                portionSize: portionSize,
                prepTime: prepTime,
                isAvailable: isAvailable,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DishesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DishesTable,
      Dishe,
      $$DishesTableFilterComposer,
      $$DishesTableOrderingComposer,
      $$DishesTableAnnotationComposer,
      $$DishesTableCreateCompanionBuilder,
      $$DishesTableUpdateCompanionBuilder,
      (Dishe, BaseReferences<_$AppDatabase, $DishesTable, Dishe>),
      Dishe,
      PrefetchHooks Function()
    >;
typedef $$StocksTableCreateCompanionBuilder =
    StocksCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> category,
      Value<double> availableQuantity,
      Value<double> minQuantity,
    });
typedef $$StocksTableUpdateCompanionBuilder =
    StocksCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> category,
      Value<double> availableQuantity,
      Value<double> minQuantity,
    });

class $$StocksTableFilterComposer
    extends Composer<_$AppDatabase, $StocksTable> {
  $$StocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get availableQuantity => $composableBuilder(
    column: $table.availableQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minQuantity => $composableBuilder(
    column: $table.minQuantity,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StocksTableOrderingComposer
    extends Composer<_$AppDatabase, $StocksTable> {
  $$StocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get availableQuantity => $composableBuilder(
    column: $table.availableQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minQuantity => $composableBuilder(
    column: $table.minQuantity,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $StocksTable> {
  $$StocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get availableQuantity => $composableBuilder(
    column: $table.availableQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minQuantity => $composableBuilder(
    column: $table.minQuantity,
    builder: (column) => column,
  );
}

class $$StocksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StocksTable,
          Stock,
          $$StocksTableFilterComposer,
          $$StocksTableOrderingComposer,
          $$StocksTableAnnotationComposer,
          $$StocksTableCreateCompanionBuilder,
          $$StocksTableUpdateCompanionBuilder,
          (Stock, BaseReferences<_$AppDatabase, $StocksTable, Stock>),
          Stock,
          PrefetchHooks Function()
        > {
  $$StocksTableTableManager(_$AppDatabase db, $StocksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<double> availableQuantity = const Value.absent(),
                Value<double> minQuantity = const Value.absent(),
              }) => StocksCompanion(
                id: id,
                name: name,
                category: category,
                availableQuantity: availableQuantity,
                minQuantity: minQuantity,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> category = const Value.absent(),
                Value<double> availableQuantity = const Value.absent(),
                Value<double> minQuantity = const Value.absent(),
              }) => StocksCompanion.insert(
                id: id,
                name: name,
                category: category,
                availableQuantity: availableQuantity,
                minQuantity: minQuantity,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StocksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StocksTable,
      Stock,
      $$StocksTableFilterComposer,
      $$StocksTableOrderingComposer,
      $$StocksTableAnnotationComposer,
      $$StocksTableCreateCompanionBuilder,
      $$StocksTableUpdateCompanionBuilder,
      (Stock, BaseReferences<_$AppDatabase, $StocksTable, Stock>),
      Stock,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      required String customerName,
      required String contactNumber,
      required String eventName,
      required DateTime eventDate,
      required DateTime bookingDate,
      required String eventPlace,
      Value<String?> decorationItems,
      Value<double> totalAmount,
      Value<double> advancePayment,
      Value<String?> paymentMode,
      Value<String?> notes,
      required String status,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<int> id,
      Value<String> customerName,
      Value<String> contactNumber,
      Value<String> eventName,
      Value<DateTime> eventDate,
      Value<DateTime> bookingDate,
      Value<String> eventPlace,
      Value<String?> decorationItems,
      Value<double> totalAmount,
      Value<double> advancePayment,
      Value<String?> paymentMode,
      Value<String?> notes,
      Value<String> status,
    });

final class $$OrdersTableReferences
    extends BaseReferences<_$AppDatabase, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrderMealsTable, List<OrderMeal>>
  _orderMealsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderMeals,
    aliasName: $_aliasNameGenerator(db.orders.id, db.orderMeals.orderId),
  );

  $$OrderMealsTableProcessedTableManager get orderMealsRefs {
    final manager = $$OrderMealsTableTableManager(
      $_db,
      $_db.orderMeals,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderMealsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OrderDishesTable, List<OrderDishe>>
  _orderDishesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderDishes,
    aliasName: $_aliasNameGenerator(db.orders.id, db.orderDishes.orderId),
  );

  $$OrderDishesTableProcessedTableManager get orderDishesRefs {
    final manager = $$OrderDishesTableTableManager(
      $_db,
      $_db.orderDishes,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderDishesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventName => $composableBuilder(
    column: $table.eventName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bookingDate => $composableBuilder(
    column: $table.bookingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventPlace => $composableBuilder(
    column: $table.eventPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get decorationItems => $composableBuilder(
    column: $table.decorationItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> orderMealsRefs(
    Expression<bool> Function($$OrderMealsTableFilterComposer f) f,
  ) {
    final $$OrderMealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderMeals,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderMealsTableFilterComposer(
            $db: $db,
            $table: $db.orderMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> orderDishesRefs(
    Expression<bool> Function($$OrderDishesTableFilterComposer f) f,
  ) {
    final $$OrderDishesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderDishes,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderDishesTableFilterComposer(
            $db: $db,
            $table: $db.orderDishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventName => $composableBuilder(
    column: $table.eventName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bookingDate => $composableBuilder(
    column: $table.bookingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventPlace => $composableBuilder(
    column: $table.eventPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get decorationItems => $composableBuilder(
    column: $table.decorationItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventName =>
      $composableBuilder(column: $table.eventName, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<DateTime> get bookingDate => $composableBuilder(
    column: $table.bookingDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventPlace => $composableBuilder(
    column: $table.eventPlace,
    builder: (column) => column,
  );

  GeneratedColumn<String> get decorationItems => $composableBuilder(
    column: $table.decorationItems,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> orderMealsRefs<T extends Object>(
    Expression<T> Function($$OrderMealsTableAnnotationComposer a) f,
  ) {
    final $$OrderMealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderMeals,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderMealsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderMeals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> orderDishesRefs<T extends Object>(
    Expression<T> Function($$OrderDishesTableAnnotationComposer a) f,
  ) {
    final $$OrderDishesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderDishes,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderDishesTableAnnotationComposer(
            $db: $db,
            $table: $db.orderDishes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, $$OrdersTableReferences),
          Order,
          PrefetchHooks Function({bool orderMealsRefs, bool orderDishesRefs})
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> contactNumber = const Value.absent(),
                Value<String> eventName = const Value.absent(),
                Value<DateTime> eventDate = const Value.absent(),
                Value<DateTime> bookingDate = const Value.absent(),
                Value<String> eventPlace = const Value.absent(),
                Value<String?> decorationItems = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> advancePayment = const Value.absent(),
                Value<String?> paymentMode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                customerName: customerName,
                contactNumber: contactNumber,
                eventName: eventName,
                eventDate: eventDate,
                bookingDate: bookingDate,
                eventPlace: eventPlace,
                decorationItems: decorationItems,
                totalAmount: totalAmount,
                advancePayment: advancePayment,
                paymentMode: paymentMode,
                notes: notes,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String customerName,
                required String contactNumber,
                required String eventName,
                required DateTime eventDate,
                required DateTime bookingDate,
                required String eventPlace,
                Value<String?> decorationItems = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> advancePayment = const Value.absent(),
                Value<String?> paymentMode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String status,
              }) => OrdersCompanion.insert(
                id: id,
                customerName: customerName,
                contactNumber: contactNumber,
                eventName: eventName,
                eventDate: eventDate,
                bookingDate: bookingDate,
                eventPlace: eventPlace,
                decorationItems: decorationItems,
                totalAmount: totalAmount,
                advancePayment: advancePayment,
                paymentMode: paymentMode,
                notes: notes,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$OrdersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({orderMealsRefs = false, orderDishesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (orderMealsRefs) db.orderMeals,
                    if (orderDishesRefs) db.orderDishes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (orderMealsRefs)
                        await $_getPrefetchedData<
                          Order,
                          $OrdersTable,
                          OrderMeal
                        >(
                          currentTable: table,
                          referencedTable: $$OrdersTableReferences
                              ._orderMealsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).orderMealsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (orderDishesRefs)
                        await $_getPrefetchedData<
                          Order,
                          $OrdersTable,
                          OrderDishe
                        >(
                          currentTable: table,
                          referencedTable: $$OrdersTableReferences
                              ._orderDishesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdersTableReferences(
                                db,
                                table,
                                p0,
                              ).orderDishesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.orderId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, $$OrdersTableReferences),
      Order,
      PrefetchHooks Function({bool orderMealsRefs, bool orderDishesRefs})
    >;
typedef $$OrderMealsTableCreateCompanionBuilder =
    OrderMealsCompanion Function({
      Value<int> id,
      required int orderId,
      required String mealType,
      required DateTime startTime,
      required DateTime endTime,
      required int numberOfPersons,
      Value<int> extraPersons,
      required double pricePerPerson,
      required double totalAmount,
    });
typedef $$OrderMealsTableUpdateCompanionBuilder =
    OrderMealsCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<String> mealType,
      Value<DateTime> startTime,
      Value<DateTime> endTime,
      Value<int> numberOfPersons,
      Value<int> extraPersons,
      Value<double> pricePerPerson,
      Value<double> totalAmount,
    });

final class $$OrderMealsTableReferences
    extends BaseReferences<_$AppDatabase, $OrderMealsTable, OrderMeal> {
  $$OrderMealsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias(
    $_aliasNameGenerator(db.orderMeals.orderId, db.orders.id),
  );

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrderMealsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderMealsTable> {
  $$OrderMealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberOfPersons => $composableBuilder(
    column: $table.numberOfPersons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get extraPersons => $composableBuilder(
    column: $table.extraPersons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerPerson => $composableBuilder(
    column: $table.pricePerPerson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderMealsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderMealsTable> {
  $$OrderMealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberOfPersons => $composableBuilder(
    column: $table.numberOfPersons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get extraPersons => $composableBuilder(
    column: $table.extraPersons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerPerson => $composableBuilder(
    column: $table.pricePerPerson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderMealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderMealsTable> {
  $$OrderMealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get numberOfPersons => $composableBuilder(
    column: $table.numberOfPersons,
    builder: (column) => column,
  );

  GeneratedColumn<int> get extraPersons => $composableBuilder(
    column: $table.extraPersons,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pricePerPerson => $composableBuilder(
    column: $table.pricePerPerson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderMealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderMealsTable,
          OrderMeal,
          $$OrderMealsTableFilterComposer,
          $$OrderMealsTableOrderingComposer,
          $$OrderMealsTableAnnotationComposer,
          $$OrderMealsTableCreateCompanionBuilder,
          $$OrderMealsTableUpdateCompanionBuilder,
          (OrderMeal, $$OrderMealsTableReferences),
          OrderMeal,
          PrefetchHooks Function({bool orderId})
        > {
  $$OrderMealsTableTableManager(_$AppDatabase db, $OrderMealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderMealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderMealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderMealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime> endTime = const Value.absent(),
                Value<int> numberOfPersons = const Value.absent(),
                Value<int> extraPersons = const Value.absent(),
                Value<double> pricePerPerson = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
              }) => OrderMealsCompanion(
                id: id,
                orderId: orderId,
                mealType: mealType,
                startTime: startTime,
                endTime: endTime,
                numberOfPersons: numberOfPersons,
                extraPersons: extraPersons,
                pricePerPerson: pricePerPerson,
                totalAmount: totalAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required String mealType,
                required DateTime startTime,
                required DateTime endTime,
                required int numberOfPersons,
                Value<int> extraPersons = const Value.absent(),
                required double pricePerPerson,
                required double totalAmount,
              }) => OrderMealsCompanion.insert(
                id: id,
                orderId: orderId,
                mealType: mealType,
                startTime: startTime,
                endTime: endTime,
                numberOfPersons: numberOfPersons,
                extraPersons: extraPersons,
                pricePerPerson: pricePerPerson,
                totalAmount: totalAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderMealsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$OrderMealsTableReferences
                                    ._orderIdTable(db),
                                referencedColumn: $$OrderMealsTableReferences
                                    ._orderIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrderMealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderMealsTable,
      OrderMeal,
      $$OrderMealsTableFilterComposer,
      $$OrderMealsTableOrderingComposer,
      $$OrderMealsTableAnnotationComposer,
      $$OrderMealsTableCreateCompanionBuilder,
      $$OrderMealsTableUpdateCompanionBuilder,
      (OrderMeal, $$OrderMealsTableReferences),
      OrderMeal,
      PrefetchHooks Function({bool orderId})
    >;
typedef $$OrderDishesTableCreateCompanionBuilder =
    OrderDishesCompanion Function({
      Value<int> id,
      required int orderId,
      required String dishName,
      Value<int> quantity,
      Value<double> price,
    });
typedef $$OrderDishesTableUpdateCompanionBuilder =
    OrderDishesCompanion Function({
      Value<int> id,
      Value<int> orderId,
      Value<String> dishName,
      Value<int> quantity,
      Value<double> price,
    });

final class $$OrderDishesTableReferences
    extends BaseReferences<_$AppDatabase, $OrderDishesTable, OrderDishe> {
  $$OrderDishesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias(
    $_aliasNameGenerator(db.orderDishes.orderId, db.orders.id),
  );

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<int>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrderDishesTableFilterComposer
    extends Composer<_$AppDatabase, $OrderDishesTable> {
  $$OrderDishesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dishName => $composableBuilder(
    column: $table.dishName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderDishesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderDishesTable> {
  $$OrderDishesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dishName => $composableBuilder(
    column: $table.dishName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderDishesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderDishesTable> {
  $$OrderDishesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dishName =>
      $composableBuilder(column: $table.dishName, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderDishesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderDishesTable,
          OrderDishe,
          $$OrderDishesTableFilterComposer,
          $$OrderDishesTableOrderingComposer,
          $$OrderDishesTableAnnotationComposer,
          $$OrderDishesTableCreateCompanionBuilder,
          $$OrderDishesTableUpdateCompanionBuilder,
          (OrderDishe, $$OrderDishesTableReferences),
          OrderDishe,
          PrefetchHooks Function({bool orderId})
        > {
  $$OrderDishesTableTableManager(_$AppDatabase db, $OrderDishesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderDishesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderDishesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderDishesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> orderId = const Value.absent(),
                Value<String> dishName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
              }) => OrderDishesCompanion(
                id: id,
                orderId: orderId,
                dishName: dishName,
                quantity: quantity,
                price: price,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int orderId,
                required String dishName,
                Value<int> quantity = const Value.absent(),
                Value<double> price = const Value.absent(),
              }) => OrderDishesCompanion.insert(
                id: id,
                orderId: orderId,
                dishName: dishName,
                quantity: quantity,
                price: price,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderDishesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$OrderDishesTableReferences
                                    ._orderIdTable(db),
                                referencedColumn: $$OrderDishesTableReferences
                                    ._orderIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrderDishesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderDishesTable,
      OrderDishe,
      $$OrderDishesTableFilterComposer,
      $$OrderDishesTableOrderingComposer,
      $$OrderDishesTableAnnotationComposer,
      $$OrderDishesTableCreateCompanionBuilder,
      $$OrderDishesTableUpdateCompanionBuilder,
      (OrderDishe, $$OrderDishesTableReferences),
      OrderDishe,
      PrefetchHooks Function({bool orderId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DishesTableTableManager get dishes =>
      $$DishesTableTableManager(_db, _db.dishes);
  $$StocksTableTableManager get stocks =>
      $$StocksTableTableManager(_db, _db.stocks);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderMealsTableTableManager get orderMeals =>
      $$OrderMealsTableTableManager(_db, _db.orderMeals);
  $$OrderDishesTableTableManager get orderDishes =>
      $$OrderDishesTableTableManager(_db, _db.orderDishes);
}
