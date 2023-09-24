<template>
    <nav>
        <div class="logo">
            <img src="../assets/icon-left-font-monochrome-white-long.png" alt="Groupomania">
        </div>
        <div class="spacer"></div>
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
        width: 100%;
    }

    .user-controls {
        min-width: fit-content;
        text-align: end;
    }
</style>