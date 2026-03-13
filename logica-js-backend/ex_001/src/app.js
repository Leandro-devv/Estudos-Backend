import express, { json } from 'express';
const app = express();

app.use(express.json);

const produtos = [
    {id: 1, item: 'parafuso', tipo:'sextavado',quantida:100},
    {id: 2, item: 'broca', tipo:'HSS',quantida:50},
    {id: 3, item: 'inserto', tipo:'TNMG',quantida:180},
    {id: 4, item: 'fresa', tipo:'topo',quantidade:10},
]

app.get('/', (req, res) => {
    res.send('O servidor está lendo este arquivo!');
});

app.get('/produtos', (req,res)=>{
    res.status(200).send(produtos);
});

app.get('/produtos/:item',(req,res)=> {
    const itemdesejado = req.params.item;
    const item = produtos.find(itemProduto => itemProduto.item.toLocaleUpperCase === itemdesejado.toLocaleUpperCase);

    if(item){
        res.status(200).send(item);
    }else{
        res.status(404).send('produto não encontrado');
    }
});

app.post('/produtos',(req,res)=>{
    produtos.push(req.body)
    res.status(201).send("Produto cadastrado com sucesso!!!")
})

export default app;
