#include <string>
#include <cstdio>

using namespace std;

int solution(string s) {
    int answer = s.size();
    for(unsigned int unit = 1; unit <= s.size(); ++unit) {
    	string compressed_string;
        string preword;
        unsigned int c = 0;
 		for(unsigned int i = 0; i < s.size(); i += unit) {
            bool equal = false;
        	string substr = s.substr(i,unit);
            if(preword.empty()) {
                equal = true;
            	preword = substr; 
            	++c;
            } else if(preword == substr) {
                equal = true;
                ++c;
            } else {
                equal = false;
            }
            
            if(equal == false) {
                if(c > 1) {
      			    compressed_string.append(to_string(c));
                }
     			compressed_string.append(preword);               
                preword = substr;
                c = 1;
            }
            
            if(i+unit >= s.size()) {
                if(c > 1) {
                	compressed_string.append(to_string(c));
                }
                
                compressed_string.append(substr);
            }
        }
        if(answer > compressed_string.size()) {
            answer = compressed_string.size();
        } 
    }
    return answer;
}
