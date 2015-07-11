# Logistics System - API de rota mais barata

## Buscar rota mais barata
Tenta encontrar a tota mais barata. Há campos a serem enviados. Caso estejam corretos e o sistema encontre os pontos A e B, retorna a rota. Caso contrário, retorna erros.

A requisição deve ser feita em `<url>/api/v1/journeys`

```
{
  journeys: {
    origin_name: "A",
    destiny_name: "B",
    truck_autonomy: 10.0,
    liter_price: 2.5
  } 
}

```
### Requisição

```http
POST <url>/api/v1/journeys
```

### Parâmetros

Nome                    |     Tipo | Descrição
------------------------|----------|------------
`origin_name`           | `string` | Nome do ponto de origem
`destiny_name`          | `string` | Nome do ponto de destino
`truck_autonomy`        |`decimal` | Autonomia do caminhão
`liter_price`           |`decimal` | Valor do litro do combustível

### Resposta

Header Status              | JSON                                                           | Descrição
---------------------------|----------------------------------------------------------------|------------
`200 OK`                   | `"journey" => {"journey" :[["A","C"],["C","B"]],"cost":7.5}`   | Rota mais barata encontrada com sucesso.
`422 Unprocessable Entity` | `"errors" => {"origin"=>["can't be blank"]}`                   | Rota não encontrada, devido aos erros descritos.
