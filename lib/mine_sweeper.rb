# frozen_string_literal: true

class MineSweeper
  EMPTY_FIELD = ' '
  MINE_FIELD = '*'
  CORNER_FIELD = '+'
  BORDER_FIELD = '|'
  TOP_BOTTOM_FIELD = '-'

  attr_accessor :size, :table

  def initialize(size = 5)
    @size = size
    @table = Array.new(size + 2) { Array.new(size + 2) }
  end

  def build_problem
    table[1, size].each do |row|
      (1..real_size - 2).each do |i|
        row[i] = random_field
      end
    end
    add_borders
    table
  end

  def print_solution
    table.map.with_index do |row, i|
      row.map.with_index do |col, j|
        col == EMPTY_FIELD ? adj_mines(i, j).to_s : col
      end
    end
  end

  private

  def adj_mines(i_pos, j_pos)
    tot = 0
    (i_pos - 1..i_pos + 1).each do |x|
      next unless x.positive? && (x <= size) # No hace falta chequear en los bordes

      (j_pos - 1..j_pos + 1).each do |y|
        tot += mine_at(x, y) if y.positive? && (y <= size)
      end
    end
    tot
  end

  def mine_at(x_pos, y_pos)
    table[x_pos][y_pos] == MINE_FIELD ? 1 : 0
  end

  def random_field
    rand(2).positive? ? MINE_FIELD : EMPTY_FIELD
  end

  def add_borders
    fill_borders
    fill_top_bottom
  end

  def fill_borders
    (1..real_size - 1).each do |i|
      table[i][0] = BORDER_FIELD
      table[i][real_size - 1] = BORDER_FIELD
    end
  end

  def fill_top_bottom
    [table.first, table.last].map! do |row|
      row.tap do |srow|
        srow[0] = CORNER_FIELD
        srow[real_size - 1] = CORNER_FIELD
        srow[1, size] = Array.new(size, TOP_BOTTOM_FIELD)
      end
    end
  end

  def real_size
    size + 2
  end
end
