#include <iostream>
#include <cmath>
#include <cstdlib>
#include <string>
#include <iomanip>
using namespace std;

//Note: Haju, use 'setw(n)' and 'setfill(a)' functions from library <iomanip> for proper spacing or for showing data in tabular form
//Also, use '\t' for spacing whenever you need to.


//Function to print dashes
void printDash(int a = 80)
{
    for (int i = 1;i<=a;i++)
    {
        cout<<"-";
    }
}

int main()
{
    //int count=1;
    int no_of_people;
    float price_of_cider = 5.5;
    float price_of_juice = 4.5;
    int sum_cider = 0; int sum_juice = 0;
    float sum_subtotal_cider = 0,sum_subtotal_juice =0;
    float sum_total=0;




    cout<<"This program calculates prices of the orders"<<endl;
    cout<<endl;

    cout<<"How many people ordered?\t";
    cin>>no_of_people;

    //name=new const char*[no_of_people];
    string name[no_of_people];
    int cider_order[no_of_people];
    int juice_order[no_of_people];
    float subtotal_cider[no_of_people];
    float subtotal_juice[no_of_people];
    float total[no_of_people];

    for(int count=0;count<no_of_people; count++)
    {
        cout<<"\nEnter the name(s) of Person #"<<count+1<<":\t";
        cin>>name[count];
        cout<<"How many orders of cider did "<<name[count]<<" have?\t";
        cin>>cider_order[count];
        cout<<"How many orders of juice did "<<name[count]<<" have?\t";
        cin>>juice_order[count];
        cout<<"\n";
    }

     for(int count=0;count<no_of_people; count++)
    {
        subtotal_cider[count]=cider_order[count]*price_of_cider;
        subtotal_juice[count]=juice_order[count]*price_of_juice;
        total[count]=subtotal_cider[count]+subtotal_juice[count];

        sum_cider=sum_cider+cider_order[count];
        sum_juice=sum_juice+juice_order[count];

        sum_subtotal_cider=sum_subtotal_cider+subtotal_cider[count];
        sum_subtotal_juice=sum_subtotal_juice+subtotal_juice[count];
        sum_total=sum_total+total[count];
    }

//    cout<<endl;
//    printDash();
//    cout<<"Names"<<setw(10)<<"Cider"<<setw(10)<<"Juice"<<setw(17)<<"Subtotal (Cider)"<<setw(17)<<"Subtotal (Juice)"<<setw(10)<<"Total\n";
//    printDash();
//    for(int count=0;count<no_of_people; count++)
//    {
//        cout<<name[count]<<setw(10)<<cider_order[count]<<setw(10)<<juice_order[count]<<setw(17)<<subtotal_cider[count]<<setw(17)<<subtotal_juice[count]<<setw(10)<<total[count]<<"\n";
//    }
//    printDash();
//    cout<<"Total"<<setw(10)<<sum_cider<<setw(10)<<sum_juice<<setw(17)<<sum_subtotal_cider<<setw(17)<<sum_subtotal_juice<<setw(10)<<sum_total;

    cout<<endl;
    printDash();
    cout<<"Names"<<"\t"<<"Cider"<<"\t"<<"Juice"<<"\t"<<"Subtotal (Cider)"<<"\t"<<"Subtotal (Juice)"<<"\t"<<"Total\n";
    printDash();
    for(int count=0;count<no_of_people; count++)
    {
        cout<<name[count]<<"\t"<<cider_order[count]<<"\t"<<juice_order[count]<<"\t\t"<<subtotal_cider[count]<<"\t\t\t"<<subtotal_juice[count]<<"\t\t"<<total[count]<<"\n";
    }
    printDash();
    cout<<"Total"<<"\t"<<sum_cider<<"\t"<<sum_juice<<"\t\t"<<sum_subtotal_cider<<"\t\t\t"<<sum_subtotal_juice<<"\t\t"<<sum_total;


    return 0;
}
