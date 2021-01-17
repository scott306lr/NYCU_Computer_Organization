#include <iostream>
#include <fstream>
#include <bitset>
#include <map>
#include <cmath>
#include <iomanip>
#include <string>
#include <algorithm>
using namespace std;


int cache_size[4]={4,16,64,256}; //kB cache size
int block_size[5]={16,32,64,128,256}; //B block size
string TXT[2]={"DCACHE","ICACHE"};
string ext=".txt";

struct Block{
    int tag=0;
    bool valid=false;
};

void compute(int a,int i,int j,int &hitCnt,int &missCnt){
    ifstream input( TXT[a]+ext ); 

    int total_blocks = (cache_size[i]<<10)/block_size[j];
    map<int,Block> cache;
    string strIn;
    while(input>>hex>>strIn){
        unsigned int memIn = stoul(strIn,nullptr,16);
        //int offset = memIn & (block_size[j]-1);
        memIn = memIn >> int( log2(block_size[j]) );
        int index = memIn & (total_blocks-1);
        memIn = memIn >> int( log2(total_blocks) );
        int tag = memIn;
        //cout<<"offset: "<<offset<<endl;
        //cout<<"index: "<<index<<endl;
        //cout<<"tag: "<<tag<<endl;
        if( cache[index].valid && cache[index].tag==tag ) hitCnt++;
        else{
            missCnt++;
            cache[index].valid = true;
            cache[index].tag = tag;
        }
        
        //cout<<endl;
    }
}


int main(){

    for(int a=0; a<2; ++a){
        cout<< TXT[a] <<":"<<endl;
        for(int i=0; i<4; ++i){
                cout<<"  Cache_size: "<< cache_size[i] <<"K"<<endl;
            for(int j=0; j<5; ++j){
                
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