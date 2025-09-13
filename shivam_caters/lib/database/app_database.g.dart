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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DishesTable dishes = $DishesTable(this);
  late final $StocksTable stocks = $StocksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dishes, stocks];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DishesTableTableManager get dishes =>
      $$DishesTableTableManager(_db, _db.dishes);
  $$StocksTableTableManager get stocks =>
      $$StocksTableTableManager(_db, _db.stocks);
}
