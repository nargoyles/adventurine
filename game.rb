#!/bin/env ruby
# encoding: utf-8

require 'colorize'

class Game
  attr_reader :moveCount, :board, :validMoves, :obstacles, :water_tiles, :gold_tiles, :message, :floor, :user, :monsters
  def initialize(user)
    @floor = 1
    @user = user
    @moveCount = 0
    @validMoves = ['w', 'a', 's', 'd', 'x', 'p', 'i', 'f']
    @obstacles = ['|', '#', '•', 'o', '°']
    @water_tiles = ['≈', '~']
    @gold_tiles = ['*', '†', 'Ω']
    @message = ""
    @monsters = [Monster.new(8,10,50,"M", 5), Monster.new(2,2,50,"M", 5), Monster.new(4,4,50,"M", 5)]
    @board = loadBoard
    addGold
  end

  def increaseMoveCount
    @moveCount += 1
  end

  def setMessage(message)
    @message = message
  end

  def setFloor(floor)
    @floor = floor
  end

  def increaseFloor
    @floor += 1
  end

  def addGold
    r = Random.new
    @board.each_with_index do |row, row_index|
      row.each_with_index do |col, col_index|
        rando = r.rand(1..100)
        unless @obstacles.include? col
          unless @water_tiles.include? col
            unless col == "E"
              if rando > 97 && col
                @board[row_index][col_index] = @gold_tiles.sample
              end
            end
          end
        end
      end
    end
  end

  def loadBoard
    @board = []
    file = File.new("#{@floor}.txt", "r")
    while (line = file.gets)
      @board.push(line.chomp.chars)
    end
    file.close
    return @board
  end

  def moveMonsters
    @monsters.each do |monster|
      monster.move(self, true)
    end
  end

  def printBoard
  #  system ("cls")
#    system "clear"
    @board.each do |row|
      row.each do |column|
        if column == @user.initial
          print "#{@user.initial}".green.on_black.underline
        elsif column == @monsters[0].initial
          print "#{@monsters[0].initial}".red.on_black.underline
        elsif @gold_tiles.include? column
          print "#{column}".yellow.on_black
        elsif @obstacles.include? column
          print "#{column}".white.on_black
        elsif @water_tiles.include? column
          print "#{column}".white.on_blue
        elsif column == "E"
          print "#{column}".white.on_black
        else
          print "#{column}".light_black.on_black
        end
      end
      puts ""
    end
    puts @message
    if @moveCount == 0
      puts "You are in the northwestern most corner of a dungeon."
      puts "Use 'a' to move west, 's' to move south, 'w' to move north, and 'd' to move east"
    end
  end
end
