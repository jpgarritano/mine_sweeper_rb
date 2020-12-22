# frozen_string_literal: true

require 'spec_helper'
require 'mine_sweeper'

describe MineSweeper do
  describe 'generated fields' do
    context 'in a problem table' do
      it 'returns MINE OR BLANK' do
        size = 2
        mine_sweeper = MineSweeper.new(size)
        mine_sweeper.build_problem[1, size].each do |row|
          expect(row[1, size].none? do |field|
                   ![MineSweeper::EMPTY_FIELD, MineSweeper::MINE_FIELD].include?(field)
                 end).to eq(true)
        end
      end
    end

    context 'in a solution 2x2 table' do
      it 'must be between 0 and 3 or *' do
        size = 2
        mine_sweeper = MineSweeper.new(size)
        mine_sweeper.build_problem
        mine_sweeper.print_solution[1, size].each do |row|
          expect(row[1, size].count { |field| ['*', '0', '1', '2', '3'].include?(field) }).to eq(size)
        end
      end
    end

    context 'in a table' do
      it 'must not have numbers at top border' do
        mine_sweeper = MineSweeper.new(4)
        expect(mine_sweeper.build_problem.first.any? { |field| field.is_a? Numeric }).to eq(false)
      end
    end
  end

  describe 'solutions values' do
    context 'on this 3x3 table generated with specific values' do
      generated_table = [['+', '-', '-', '-', '+', '+'],
                         ['|', '*', '*', '*', '|', '|'],
                         ['|', ' ', ' ', '*', '|', '|'],
                         ['|', ' ', '*', ' ', '|', '|'],
                         ['|', ' ', '*', '*', '|', '|'],
                         ['+', '-', '-', '-', '+', '+']]
      mine_sweeper = MineSweeper.new(3)
      mine_sweeper.table = generated_table
      solution = mine_sweeper.print_solution
      it 'must be a mine' do
        expect(solution[1][1]).to eq('*')
      end

      it 'must be a number 3' do
        expect(solution[2][1]).to eq('3')
      end
    end
  end
end
