#include "simulator.h" 

using namespace std;

Simulator::Simulator()
{
    freePeople=new Group();
    freePeople->male=initalFreeMale;
    freePeople->female=initalFreeFemale;
    
    families=new Family*[MAX_FAMILY];
    for(int i=0;i<MAX_FAMILY;i++)
    {
        families[i]=NULL;
    }
    familyCount=0;
}

Simulator::~Simulator()
{
    delete freePeople;
    
    for(int i=0;i<MAX_FAMILY;i++)
    {
        if (families[i]) delete families[i];
    }
}

void Simulator::start(int generation)
{
    /*
    for (int i=0;i<MAX_FAMILY;i++)
        createFamily();
    for (int i=0;i<MAX_FAMILY;i++)
        removeFamily(families[0]);
    */
    for (int i=1; i<=generation; i++)
    {
        death();
        growUp();
        birth();
        marriage();
        output(i);
        sleep(1);   //Slow down stimulation in order to make random number more "randomly"
    }    
}

void Simulator::createFamily()
{
    if (familyCount>=MAX_FAMILY) return;
    Family* tempFamily;
    tempFamily=new Family();
    families[familyCount++]=tempFamily;   //Append the new family to the famillies array
}
void Simulator::removeFamily(Family* family)
{
    for(int i=0;i<familyCount;i++)
    {
        if (families[i]==family)
        {
            delete families[i];
            if (familyCount>0)
            {
                families[i]=families[--familyCount];  //Replace this family with the family at the end of array
                families[familyCount]=NULL;
            }
            else
            {
                families[i]=NULL;
            }
            break;
        }
    }
}

void Simulator::marriage()
{
    srand((unsigned)time(NULL));    //Set random seed
    int totalMale = freePeople->male;
    for (int i=0;i<totalMale; i++)
    {
        //Pick a man first
        if (freePeople->female==0) return;   //No chance to have a marriage: either him or left bachelors
        if (rand() < natureMarriage)  //Decided to get married
        {
            createFamily();
            freePeople->male--;
            freePeople->female--;
        }
    }
}

void Simulator::birth()
{
    srand((unsigned)time(NULL));    //Set random seed
    int n;
    int i,j;
    for (i=0; i<familyCount; i++)
    {
        if (rand()<natureBirth)
        {
            n = natureBirthPerson * rand() ;   //How many children one would get
            for (j=0;j<n;j++)
            {
                families[i]->bear(rand() < natureManBirth); //Get a boy or girl
            }
        }
    }
}

void Simulator::growUp()
{
    Group* tempGroup;
    for (int i=0; i<familyCount; i++)
    {
        tempGroup=families[i]->growUp();        
        if (tempGroup)  //The grown-ups from family come into the group of free people
        {
            freePeople->male += tempGroup->male;
            freePeople->female += tempGroup->female;
            delete tempGroup;
        }
    }
}

void Simulator::death()
{
    srand((unsigned)time(NULL));    //Set random seed
    int n;
    int i,j;
    for (i=0; i<familyCount; i++)
    {
        if (rand() < natureParentsDeath)    //One of the parent will die
        {
            families[i]->dead(rand() < natureManDeath, true);   //Father or mother die              
        }
        n=families[i]->countChildren();
        for (j=0; j<n; j++)
        {
            if (rand() < natureDeath)   //Children j in family will die
            {
                families[i]->dead(rand() < natureManDeath, false);   //A boy or girl die              
            }
        }
        if (families[i]->getPopulation()==0) removeFamily(families[i]);   //Familiy disapper
    }
    
    n= freePeople->male + freePeople->female;
    for (i=0; i<n; i++)
    {
        if (rand() < natureDeath)   //Free person i will die
        {
            freePeople->removePerson(rand() < natureManDeath);  //A man or woman die
        }
    }
}

int Simulator::countFamily()
{
    return familyCount;
}

int Simulator::countTotalPerson()
{
    int count = 0;
    for (int i=0;i<familyCount;i++)
    {
        count+=families[i]->getPopulation();
    }
    return count;
}

int Simulator::countFreePeople()
{
    return freePeople->male + freePeople->female;
}

float Simulator::getSexRatio()
{
    int male=0,female=0;
    Group* tempGroup;
    for (int i=0;i<familyCount;i++)
    {
        tempGroup=families[i]->getGroup();
        male+=tempGroup->male;
        female+=tempGroup->female;
        delete tempGroup;
    }
    return float(male)/female;
}

void Simulator::output(int generation)    //Print the current status
{
    if (generation==1)   cout<< "Gener." << "\tTotal" << "\tFamily" << "\tFree" << "\tRatio" << endl;
    cout << generation << "\t" << countTotalPerson() << "\t" << countFamily() << "\t" << countFreePeople() << "\t" << getSexRatio() << endl;
}