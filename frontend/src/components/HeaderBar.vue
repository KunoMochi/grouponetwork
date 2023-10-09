<template>
    <nav>
        <div class="logo">
            <img src="../assets/icon-left-font-monochrome-white-long.png" alt="Groupomania">
        </div>
        <div class="spacer">
            <input class="search-box" />
            <button class="search-button">Search</button>
        </div>
        <div class="user-controls">
            <router-link to="/login">Login</router-link> | 
            <router-link to="/signup">Sign up</router-link>
        </div>
    </nav>
</template>

<style lang="scss">
    nav {
        display: flex;
        text-align: left;
        background-color: #474747;
        padding: 1rem;
        
        a {
            font-weight: bold;
            color: white;
            text-decoration: none;
        }
    }

    .logo {
        img {
            height: 2em;
        }
    }

    .spacer {
        text-align: right;
        width: 100%;
        padding: 0 1rem 0 1rem;

        .search-box {
            width: 20rem;
        }
    }

    .user-controls {
        min-width: fit-content;
    }
</style>