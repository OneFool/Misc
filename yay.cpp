#include <iostream>

// POV: I am bad at c++

int main(){
    
    std::string name;
    int age;

    std::cout << "What's your full name?: ";
    std::getline(std::cin, name);
    std::cout << "What's youre age? ";
    std::cin >> age;

    std::cout << "Hello " << name << '\n';
    std::cout << "You are " << age << " years old";

    return 0;
}
