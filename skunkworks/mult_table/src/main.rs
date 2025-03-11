fn main() {
    bubble();
}

#[allow(dead_code)]
fn mult_table() {
    let max = 13;
    println!("---|");
    for i in 0..max {
        print!("{:3}", i)
    }
    println!("\n----|{}", "-".repeat(max * 4));
    for i in 0..max {
        print!("{:2} |", i);
        for v in 0..max {
            print!("{:3} ", i * v)
        }
        println!();
    }
}

fn bubble() {
    let mut items = [23, 234, 5, 23234, 23, 423, 4];
    let n = items.len();

    for i in 0..items.len() {
        for j in 0..(n - i - 1) {
            if items[j] > items[j + 1] {
                items.swap(j, j + 1);
            }
        }
    }
    println!("sorted items are {:#?}", items)
}
