class group
{
public:
    group();
    ~group();
    
    int male, female;   //Population of male and female
    
    float getRatio();
    void addPerson(bool isMale);
    void removePerson(bool isMale);
};