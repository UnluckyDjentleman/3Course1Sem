const http=require('http');
const util=require('util');
const event=require('events');

let db=[
    {
        id: 1,
        name: "Jane Doe",
        bday: "07-11-2003"
    },
    {
        id: 2,
        name: "Bunka Singh",
        bday: "04-12-2003"
    },
    {
        id: 3,
        name: "Mikael Lundgren",
        bday: "23-01-2004"
    },
    {
        id: 4,
        name: "Miho Sakura",
        bday: "30-08-2003"
    },
    {
        id: 5,
        name: "Olena Kravchenko",
        bday: "08-03-2004"
    },
    {
        id: 6,
        name: "Tuomas Laaksoharju",
        bday: "12-05-2004"
    },
    {
        id: 7,
        name: "Edith Beauchemin",
        bday: "28-09-2003"
    },
    {
        id: 8,
        name: "Diana Wijl",
        bday: "31-07-2004"
    },
    {
        id: 9,
        name: "Liza Gonzalez",
        bday: "06-02-2004"
    },
    {
        id: 10,
        name: "Josip Vukojevic",
        bday: "17-10-2003"
    },
    {
        id: 11,
        name: "Joao Santos",
        bday: "22-06-2004"
    },
    {
        id: 12,
        name: "Tim Kolzig",
        bday: "05-04-2004"
    }
];
function DB(){
    this.select=()=>{
        return JSON.stringify(db)
    }
    this.insert=(newString)=>{
        for(let i=0;i<db.length;i++){
            if(JSON.parse(newString).id==db[i].id){
                return;
            }
        }
        console.log("[INSERT]\n");
        db.push(JSON.parse(newString));
        return JSON.stringify(db);
    }
    this.update=(updateString)=>{
        var id = JSON.parse(updateString).id;
        var index=db.findIndex(elem=>
            elem.id===parseInt(id)
        )
        db[index].name=JSON.parse(updateString).name;
        db[index].bday=JSON.parse(updateString).bday;
        return JSON.stringify(db[index]);
    }
    this.delete=(deleteId)=>{
        var index=db.findIndex(elem=>
            elem.id===parseInt(deleteId))
        var deleteElem=db[index];
        db.splice(index,1);
        return JSON.stringify(deleteElem);
    }
}
util.inherits(DB,event.EventEmitter);
exports.DB=DB;