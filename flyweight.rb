# Клас TreeType зберігає загальну інформацію про тип дерева (внутрішній стан)
class TreeType
  attr_reader :name, :color, :texture

  def initialize(name, color, texture)
    @name = name
    @color = color
    @texture = texture
  end

  # Цей метод малює дерево, використовуючи внутрішній і зовнішній стан
  def draw(x, y)
    puts "Drawing a #{@name} tree at coordinates (#{x}, #{y}) with color #{@color} and texture #{@texture}."
  end
end

# Фабрика, яка створює або повертає вже існуючі об'єкти TreeType
class TreeFactory
  @tree_types = {}

  def self.get_tree_type(name, color, texture)
    key = "#{name}_#{color}_#{texture}"

    # Якщо такий тип дерева вже є, повертаємо його
    return @tree_types[key] if @tree_types[key]

    # Інакше створюємо новий і зберігаємо його
    tree_type = TreeType.new(name, color, texture)
    @tree_types[key] = tree_type
    tree_type
  end
end

# Клас Tree містить зовнішній стан (координати) і посилається на внутрішній стан (TreeType)
class Tree
  def initialize(x, y, tree_type)
    @x = x
    @y = y
    @tree_type = tree_type
  end

  # Метод для малювання дерева на конкретних координатах
  def draw
    @tree_type.draw(@x, @y)
  end
end

# Клас Forest керує всіма деревами
class Forest
  def initialize
    @trees = []
  end

  # Додає нове дерево в ліс
  def plant_tree(x, y, name, color, texture)
    # Отримуємо тип дерева через фабрику (Flyweight)
    tree_type = TreeFactory.get_tree_type(name, color, texture)
    # Створюємо дерево з координатами і посиланням на його тип
    tree = Tree.new(x, y, tree_type)
    @trees << tree
  end

  # Малює всі дерева в лісі
  def draw
    @trees.each(&:draw)
  end
end

# Створюємо новий ліс
forest = Forest.new

# Садимо дерева
forest.plant_tree(10, 20, 'Oak', 'Green', 'Rough')
forest.plant_tree(30, 40, 'Oak', 'Green', 'Rough')
forest.plant_tree(50, 60, 'Pine', 'Dark Green', 'Smooth')

# Малюємо всі дерева в лісі
forest.draw