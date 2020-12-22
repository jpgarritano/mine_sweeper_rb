class MineSweeper
  EMPTY_FIELD = " ".freeze
  MINE_FIELD = "*".freeze
  CORNER_FIELD = "+".freeze
  BORDER_FIELD = "|".freeze
  TOP_BOTTOM_FIELD = '-'.freeze

  attr_accessor :size, :table

  def initialize(size=5)
    @size = size
    @table = Array.new(size+2) { Array.new(size+2)}
  end

  def build_problem
    table[1,size].each do |row|
      for i in 1..real_size-2
        row[i] = get_random_field
      end
    end
    add_borders
    table
  end

  def print_solution
    self.table.map.with_index do |row, i|
      row.map.with_index do |col, j| 
        col = (col == EMPTY_FIELD) ? adj_mines(i,j).to_s : col
      end
    end
  end

  def adj_mines i,j
    tot = 0
    for x in i-1..i+1
      if x>0 and x <= size #No hace falta chequear en los bordes
        for y in j-1..j+1
          if y>0 and y<=size
            tot += mine_at(x,y)
          end
        end
      end
    end
    tot
  end

  def mine_at(x,y)
    table[x][y] == MINE_FIELD ? 1 : 0
  end

  def get_random_field
    (rand(2) > 0) ? MINE_FIELD : EMPTY_FIELD
  end

  def add_borders
    for i in 1..real_size-1
      table[i][0] = BORDER_FIELD
      table[i][real_size-1] = BORDER_FIELD
    end
    [table.first, table.last].map! do | row |
      row.tap do | srow | 
        srow[0] = CORNER_FIELD;
        srow[real_size-1] = CORNER_FIELD;
        srow[1,size] = Array.new(size,TOP_BOTTOM_FIELD)
      end
    end
  end


  private

  def real_size
    size + 2
  end
end