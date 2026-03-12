import express from 'express'
const app = express()

const produtos = [
    {id: 1, item: 'parafuso', tipo:'sextavado',quantida:100},
    {id: 2, item: 'broca', tipo:'HSS',quantida:50},
    {id: 3, item: 'inserto', tipo:'TNMG',quantida:180},
    {id: 4, item: 'fresa', tipo:'topo',quantida:10},
]

app.get('/' ,(req,res) => {
    res.send("hello world")
});

app.get('/produtos/:item',(req,res)=> {
    const itemdesejado = req.params.item;
    const item = produtos.find(itemProduto => itemProduto.item === itemdesejado)

    if(item){
        res.status(200).send(item)
    }else{
        res.status(404).send('produto não encontrado')
    }
})

export default app;
