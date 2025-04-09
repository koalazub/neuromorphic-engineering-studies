fn main():
    board()


fn board():
    num_cols = 8
    num_rows = 8

    glider = List(
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
        List(0, 1, 0, 0, 0, 0, 0),
    )

    result = grid_str(num_rows, num_cols, glider)
    print(result)


fn grid_str(rows: Int, cols: Int, grid: List[List[Int]]) -> String:
    str = String()

    for row in range(rows):
        for col in range(cols):
            if grid[row][col] == 1:
                str += "*"
            else:
                str += " "
        if row != rows - 1:
            str += "\n"
    return str
