<template>
    <aside>
        <router-link to="/">Home</router-link>
        <router-link to="/profile">Profile</router-link>
        <router-link to="/forum">Forum</router-link>
    </aside>
</template>

<script>
    export default {
        name: 'SidebarComp'
    }
</script>

<style lang="scss">
    aside {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        overflow: hidden;
        padding: 1rem;
    }
</style>