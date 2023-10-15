<template>
    <aside>
        <div class="home">
            <router-link to="/">Home</router-link>
        </div>
        <div class="forum">
            <router-link to="/forum">Forum</router-link>
        </div>
        <div class="profile">
            <router-link to="/profile">Profile</router-link>
        </div>
    </aside>
</template>

<script>

</script>

<style lang="scss" scoped>
    aside {
        text-align: left;
        display: flex;
        flex-direction: column;
        width: calc(4rem + 32px);
        min-height: calc(100vh - 200px);
        overflow: hidden;
        padding: 1rem;

        background-color: #474747;

        div {
            margin-bottom: 1rem;
        }

        a {
            font-weight: bold;
            color: white;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            position: fixed;
            z-index: 99;
        }
    }
</style>