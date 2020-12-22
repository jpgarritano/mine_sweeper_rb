# frozen_string_literal: true

require 'spec_helper'
require 'mine_sweeper'

describe MineSweeper do
  let(:mine_sweeper) { MineSweeper.new(4) }
  describe 'generated fields' do
    context 'in a problem table' do
      it 'returns MINE OR BLANK' do
        mine_sweeper.build_problem[1, mine_sweeper.size].each do |row|
          expect(row[1, mine_sweeper.size].none? do |field|
                   ![MineSweeper::EMPTY_FIELD, MineSweeper::MINE_FIELD].include?(field)
                 end).to eq(true)
        end
      end
      it 'must not have numbers at top border' do
        expect(mine_sweeper.build_problem.first.any? { |field| field.is_a? Numeric }).to eq(false)
      end
    end
    context 'in a solution 2x2 table' do
      it 'must be between 0 and 3 or *' do
        possible_values = ['*', Array('1'..'8')].flatten
        mine_sweeper.build_problem
        mine_sweeper.print_solution[1, mine_sweeper.size].each do |row|
          expect(row[1, mine_sweeper.size].count { |field| possible_values.include?(field) }).to eq(mine_sweeper.size)
        end
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
