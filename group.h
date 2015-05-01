#ifndef GROUP_H_
#define GROUP_H_
class Group
{
public:
    Group();
    ~Group();
    
    int male, female;   //Population of male and female
    
    float getRatio();
    void addPerson(bool isMale);
    void removePerson(bool isMale);
};
#endif