fn print_number (fibonacci_number : u32, value : u64) {
    println!("F({}) = {}", fibonacci_number, value);
}


fn main() {
    loop {
        println!("Bis zu welcher Zahl sollen die Fibonaccizahlen ausgegeben werden?");
        let mut number = String::new();
        std::io::stdin().read_line(&mut number).expect("Zeile konnte nicht gelesen werden.");

        let number: u32 = match number.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
        let mut fbminus2 : u64 = 0;
        let mut fbminus1 : u64 = 1;
        for i in 1..(number+1){
            if i == 1 {
                print_number(1, 1);
            } else{
                let fb = fbminus1 + fbminus2;
                print_number(i, fb);
                fbminus2 = fbminus1;
                fbminus1 = fb;
            }
        }
        break;
    }


}


