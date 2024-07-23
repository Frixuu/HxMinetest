<script setup lang="ts">

  import TypeRef from './TypeRef.vue';
  const props = defineProps<{name: string, returnType: any}>();

</script>

<template>
  <span>
    <slot name="pre"></slot>
    <span class="code">
      <strong class="name">{{ name }}</strong>:
      <span class="type" v-if="returnType"><TypeRef :type="returnType" /></span>
      <slot></slot>
    </span>
    <slot name="post"></slot>
  </span>
</template>

<style scoped lang="scss">
  .code {
    font-family: var(--vp-font-family-mono);
  }
</style>
