# inception

this is my inception 
i love inceptioning things and also mermaids

[Notion](https://river-weight-158.notion.site/Inception-8b6b536241144669907e9a8b2b7c9723)

# Infrastructure 
```mermaid
graph LR
    WEB[WWW] <--> |443|NX

    subgraph ComputerHost
        DockerNetwork
        Volumes
    end

    subgraph DockerNetwork
    DB
    WP
    NX
    end

    subgraph Volumes
    WPvol
    DBvol
    end 

    NX["`Container
    NGINX`"]
    WP["`Container
    Wordpress`"]
    DB["`Container
    DB`"]
    
    WPvol[(WP)]
    DBvol[(DB)]

    NX <--> |9000| WP
    WP <--> |3306| DB
    
    DB <--> DBvol
    WP <--> WPvol
    NX <--> WPvol
```
