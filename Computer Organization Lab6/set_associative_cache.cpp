#include <iostream>
#include <fstream>
#include <bitset>
#include <map>
#include <cmath>
#include <iomanip>
#include <string>
#include <algorithm>
using namespace std;
int cache_size[7]={1,2,4,8,16,32,64}; //kB cache size
int block_size[1]={64}; //B block size
int associativity[4]={1,2,4,8}; //B block size
string TXT[1]={"LRU"};
string ext=".txt";

struct Block{
    int tag[8]={0};
    bool valid[8]={false};
};

bool read_cache(map<int,Block> &cache, int way, int index, int tag){
    int result=-1;
    for(int i=0;i<way;i++){
        if( cache[index].valid[i] && cache[index].tag[i]==tag )
        result=i;
    }
    
    if(result!=-1){         //hit
        
        for(int i=result; i>=1; --i){
            swap(cache[index].valid[i], cache[index].valid[i-1]);
            swap(cache[index].tag[i], cache[index].tag[i-1]);
        }
        return true;

    }else{                  //miss
        
        for(int i=way-1; i>=1; --i){
            cache[index].valid[i] = cache[index].valid[i-1];
            cache[index].tag[i] = cache[index].tag[i-1];
        }
        cache[index].valid[0]=true;
        cache[index].tag[0]=tag;
        return false;
        
    }
}

void compute(int a,int i,int j,int &hitCnt,int &missCnt){
    ifstream input( TXT[0]+ext ); 
    int total_blocks = (cache_size[i]<<10)/block_size[j];
    map<int,Block> cache;
    string strIn;
    int way = associativity[a];
    while(input>>hex>>strIn){
        unsigned int memIn = stoul(strIn,nullptr,16);
        //int offset = memIn & (block_size[j]-1);
        memIn = memIn >> int( log2(block_size[j]) );
        int index = memIn & (total_blocks/associativity[a]-1);
        memIn = memIn >> int( log2(total_blocks/associativity[a]) );
        int tag = memIn;
        //
        if( read_cache(cache,way,index,tag) ) hitCnt++;
        else missCnt++;
    }
}

int main(){
    for(int a=0; a<4; ++a){
        cout<< associativity[a] <<"-way:"<<endl;
        for(int i=0; i<7; ++i){
            cout<<"   Cache_size: "<< cache_size[i] <<"K"<<endl;
            for(int j=0; j<1; ++j){   
                int hitCnt=0,missCnt=0;
                compute(a,i,j,hitCnt,missCnt);
                int total = hitCnt+missCnt;
                double hitRate = hitCnt*100.0 / total;         
                cout<<"\tBlock_size: "<<block_size[j] <<endl;
                cout<<"\tHit rate: "<< fixed <<setprecision(2)<<   hitRate  <<"% ("<<hitCnt <<"),  ";
                cout<<"Miss rate: " << fixed <<setprecision(2)<<  100-hitRate <<"% ("<<missCnt<<")"<< endl<<endl;
            }
        }
    }
}
