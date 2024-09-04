# Inception

Installation of an LEMP architecture decoupled with docker containers and running on a virtual machine.

# Services
- An https server : NGINX with TLSv1.2 or TLSv1.3 only.
- A content management system : WordPress + php-fpm (installed and configured).
- A database : MariaDB

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

# Useful links
Notes, documentation plus some extra links on the project are on my notion : 
[Notion](https://river-weight-158.notion.site/Inception-8b6b536241144669907e9a8b2b7c9723)

