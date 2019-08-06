#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <string>
#include <istream>
#include <functional>
#include <set>


std::vector<std::string> split(const std::string& s, char delimiter){
   std::vector<std::string> tokens;
   std::string token;
   std::istringstream tokenStream(s);
   while (std::getline(tokenStream, token, delimiter))
   {
      tokens.push_back(token);
   }
   return tokens;
}

void eraseSubStr(std::string& main_str, const std::string& toErase)
{
	// Search for the substring in string
	size_t pos = std::string::npos; //main_str.find(toErase);
 
	while ((pos = main_str.find(toErase)) != std::string::npos){
        main_str.erase(pos, toErase.length());
    }
}


void strip(std::string& main_str, const std::vector<std::string>strList){
    std::for_each(strList.begin(), strList.end(), std::bind(eraseSubStr, std::ref(main_str), std::placeholders::_1));
}

struct Guard{
    int id;
    std::vector<int> min_asleep;
    std::string date;
    int total_min_asleep;

    Guard() = default;

    Guard(int guard_id, std::vector<std::string>* input_data) {
        id = guard_id;
    }
};

// read each line of stdin
std::vector<std::string> file_read() {
    std::vector<std::string> th;
    std::string x;
    
    while (getline(std::cin, x)) {
        th.push_back(x);
    }
    std::sort(th.begin(), th.end());
    return th;
}

std::vector<int> get_ids(std::vector<std::string>* input_data){
    std::vector<int> ids;
    std::vector<std::string> c {"#"};
    // use set to get each id once
    std::set<int> unique_ids;
    for(auto n: *input_data){
        size_t pos = n.find('#');
        if (!(pos > n.length())){
            std::string id = n.substr(pos);
            size_t space_pos = id.find_first_of(' ');
            id = n.substr(pos, space_pos);
            strip(id, c);
            unique_ids.emplace(atoi(id.c_str()));
        }
    }
    for (auto n: unique_ids){
        ids.push_back(n);
    }
    return ids;
}

int main(){

    // Maintain a vector of guards
    std::vector<Guard> guards;

    auto input_data = file_read();
    auto ids = get_ids(&input_data);
    for (auto n: ids){
        Guard guard = Guard(n, &input_data);
    }

    return 0;
}




