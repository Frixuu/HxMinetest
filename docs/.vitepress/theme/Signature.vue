<script setup lang="ts">
  const props = defineProps(["name", "typeParams", "args", "returnType"]);
</script>

<template>
  <span>
    <slot name="pre"></slot>
    <span class="code">
      <strong>{{ name }}</strong>
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
