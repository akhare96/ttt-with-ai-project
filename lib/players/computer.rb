module Players
    class Computer < Player


        WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
        ]
        
        /
        ttt strategy:
        - Move in the middle cell
        - if middle cell not available, then check if you can win
        - check to see if you can block opponents move
        - move in corners
        - move in rest of the spots
        - repeat until over
        /

        def opponent
            if token == "X"
                "O"
            else
                "X"
            end
        end

        def move(board)
            @board = board
            if win_move
              win_move
            elsif block_move
              block_move
            elsif center
              center
            elsif corner
              corner
            else
                cross
            end
        end

        def win_move
            win = WIN_COMBINATIONS.detect {|combo|
                @board.cells[combo[0]] == token && @board.cells[combo[1]] == token && @board.cells[combo[2]] == " " ||
                @board.cells[combo[0]] == token && @board.cells[combo[1]] == " " && @board.cells[combo[2]] == token ||
                @board.cells[combo[0]] == " " && @board.cells[combo[1]] == token && @board.cells[combo[2]] == token
            }

            if win
                spot = win.detect {|space| @board.cells[space] == " "}
                number = spot.to_i + 1
                number.to_s 
            end
        end

        def block_move
            defense = WIN_COMBINATIONS.detect {|combo|
                @board.cells[combo[0]] == opponent && @board.cells[combo[1]] == opponent && @board.cells[combo[2]] == " " ||
                @board.cells[combo[0]] == opponent && @board.cells[combo[1]] == " " && @board.cells[combo[2]] == opponent ||
                @board.cells[combo[0]] == " " && @board.cells[combo[1]] == opponent && @board.cells[combo[2]] == opponent
            }

            if defense 
                spots = defense.detect {|space| @board.cells[space] == " "}
                numbers = spots.to_i + 1
                numbers.to_s
            end
        end

        def center
            if @board.cells[4] == " "
                "5"
            end
        end

        def corner
            if @board.cells[0] == " "
                "1"
            elsif @board.cells[2] == " "
                "3"
            elsif @board.cells[6] == " "
                "7"
            elsif @board.cells[8] == " "
                "9"
            end
        end

        def cross
            if @board.cells[1] == " "
                "2"
            elsif @board.cells[3] == " "
                "4"
            elsif @board.cells[5] == " "
                "6"
            elsif @board.cells[7] == " "
                "8"
            end
        end
    end
end