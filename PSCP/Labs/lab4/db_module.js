const http=require('http');
const util=require('util');
const event=require('events');
const { EventEmitter } = require('stream');

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
class DB extends EventEmitter{
    select=async ()=>{
        return await JSON.stringify(db.sort((a,b)=>a.id-b.id))
    }
    insert=async (newString)=>{
        for(let i=0;i<db.length;i++){
            if(JSON.parse(newString).id==db[i].id){
                return;
            }
        }
        console.log("[INSERT]\n");
        db.push(JSON.parse(newString));
        return await JSON.stringify(db);
    }
    update=async(updateString)=>{
        console.log(db);
        console.log(JSON.parse(updateString));
        var id = JSON.parse(updateString).id;
        console.log("id to update: " + id + "\n")
        var index=db.findIndex(elem=>elem.id===parseInt(id));
        console.log(db[index]);
        db[index].name=JSON.parse(updateString).name;
        db[index].bday=JSON.parse(updateString).bday;
        return await JSON.stringify(db[index]);
    }
    delete=async(deleteId)=>{
        var index=db.findIndex(elem=>
            elem.id===parseInt(deleteId));
        var deleteElem=db[index];
        db.splice(index,1);
        return await JSON.stringify(deleteElem);
    }
}
exports.DB=DB;