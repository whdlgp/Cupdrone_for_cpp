# 1 ".//src/baseflight_startups/startup_stm32f10x_md_gcc.S"
# 1 "<command-line>"
# 1 ".//src/baseflight_startups/startup_stm32f10x_md_gcc.S"
# 31 ".//src/baseflight_startups/startup_stm32f10x_md_gcc.S"
  .syntax unified
 .cpu cortex-m3
 .fpu softvfp
 .thumb

.global g_pfnVectors
.global Default_Handler



.word _sidata

.word _sdata

.word _edata

.word _sbss

.word _ebss

.equ BootRAM, 0xF108F85F
# 61 ".//src/baseflight_startups/startup_stm32f10x_md_gcc.S"
.section .text.Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
 ldr r0, =0x20004FF0
 ldr r1, =0xDEADBEEF
 ldr r2, [r0, #0]
 str r0, [r0, #0]
 cmp r2, r1
 beq Reboot_Loader


  movs r1, #0
  b LoopCopyDataInit

CopyDataInit:
 ldr r3, =_sidata
 ldr r3, [r3, r1]
 str r3, [r0, r1]
 adds r1, r1, #4

LoopCopyDataInit:
 ldr r0, =_sdata
 ldr r3, =_edata
 adds r2, r0, r1
 cmp r2, r3
 bcc CopyDataInit
 ldr r2, =_sbss
 b LoopFillZerobss

FillZerobss:
 movs r3, #0
 str r3, [r2], #4

LoopFillZerobss:
 ldr r3, = _ebss
 cmp r2, r3
 bcc FillZerobss


    bl SystemInit

    bl __libc_init_array

 bl main

LoopForever:
    b LoopForever

.equ RCC_APB2ENR, 0x40021018
.equ GPIO_AFIO_MASK, 0x00000009
.equ GPIOB_CRL, 0x40010C00
.equ GPIOB_BRR, 0x40010C14
.equ AFIO_MAPR, 0x40010004

Reboot_Loader:

     ldr r6, =RCC_APB2ENR
     ldr r0, =GPIO_AFIO_MASK
     str R0, [r6];


        ldr r0, =AFIO_MAPR
        ldr r1, [r0]
        bic r1, r1, #0x0F000000
        str r1, [r0]


        lsls r1, r0, #9
        str r1, [r0]


        ldr r4, =GPIOB_BRR
        movs r0, #0x18
        str r0, [r4]


        ldr r1, =GPIOB_CRL
        ldr r0, =0x44433444
        str r0, [r1]


        ldr r0, =0x1FFFF000
        ldr sp,[r0, #0]
        ldr r0,[r0, #4]
        bx r0

.size Reset_Handler, .-Reset_Handler
# 158 ".//src/baseflight_startups/startup_stm32f10x_md_gcc.S"
    .section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
 b Infinite_Loop
 .size Default_Handler, .-Default_Handler







  .section .isr_vector,"a",%progbits
 .type g_pfnVectors, %object
 .size g_pfnVectors, .-g_pfnVectors


g_pfnVectors:
 .word _estack
 .word Reset_Handler
 .word NMI_Handler
 .word HardFault_Handler
 .word MemManage_Handler
 .word BusFault_Handler
 .word UsageFault_Handler
 .word 0
 .word 0
 .word 0
 .word 0
 .word SVC_Handler
 .word DebugMon_Handler
 .word 0
 .word PendSV_Handler
 .word SysTick_Handler
 .word WWDG_IRQHandler
 .word PVD_IRQHandler
 .word TAMPER_IRQHandler
 .word RTC_IRQHandler
 .word FLASH_IRQHandler
 .word RCC_IRQHandler
 .word EXTI0_IRQHandler
 .word EXTI1_IRQHandler
 .word EXTI2_IRQHandler
 .word EXTI3_IRQHandler
 .word EXTI4_IRQHandler
 .word DMA1_Channel1_IRQHandler
 .word DMA1_Channel2_IRQHandler
 .word DMA1_Channel3_IRQHandler
 .word DMA1_Channel4_IRQHandler
 .word DMA1_Channel5_IRQHandler
 .word DMA1_Channel6_IRQHandler
 .word DMA1_Channel7_IRQHandler
 .word ADC1_2_IRQHandler
 .word USB_HP_CAN1_TX_IRQHandler
 .word USB_LP_CAN1_RX0_IRQHandler
 .word CAN1_RX1_IRQHandler
 .word CAN1_SCE_IRQHandler
 .word EXTI9_5_IRQHandler
 .word TIM1_BRK_IRQHandler
 .word TIM1_UP_IRQHandler
 .word TIM1_TRG_COM_IRQHandler
 .word TIM1_CC_IRQHandler
 .word TIM2_IRQHandler
 .word TIM3_IRQHandler
 .word TIM4_IRQHandler
 .word I2C1_EV_IRQHandler
 .word I2C1_ER_IRQHandler
 .word I2C2_EV_IRQHandler
 .word I2C2_ER_IRQHandler
 .word SPI1_IRQHandler
 .word SPI2_IRQHandler
 .word USART1_IRQHandler
 .word USART2_IRQHandler
 .word USART3_IRQHandler
 .word EXTI15_10_IRQHandler
 .word RTCAlarm_IRQHandler
 .word USBWakeUp_IRQHandler
  .word 0
 .word 0
 .word 0
 .word 0
 .word 0
 .word 0
 .word 0
 .word BootRAM
# 253 ".//src/baseflight_startups/startup_stm32f10x_md_gcc.S"
  .weak NMI_Handler
 .thumb_set NMI_Handler,Default_Handler

  .weak HardFault_Handler
 .thumb_set HardFault_Handler,Default_Handler

  .weak MemManage_Handler
 .thumb_set MemManage_Handler,Default_Handler

  .weak BusFault_Handler
 .thumb_set BusFault_Handler,Default_Handler

 .weak UsageFault_Handler
 .thumb_set UsageFault_Handler,Default_Handler

 .weak SVC_Handler
 .thumb_set SVC_Handler,Default_Handler

 .weak DebugMon_Handler
 .thumb_set DebugMon_Handler,Default_Handler

 .weak PendSV_Handler
 .thumb_set PendSV_Handler,Default_Handler

 .weak SysTick_Handler
 .thumb_set SysTick_Handler,Default_Handler

 .weak WWDG_IRQHandler
 .thumb_set WWDG_IRQHandler,Default_Handler

 .weak PVD_IRQHandler
 .thumb_set PVD_IRQHandler,Default_Handler

 .weak TAMPER_IRQHandler
 .thumb_set TAMPER_IRQHandler,Default_Handler

 .weak RTC_IRQHandler
 .thumb_set RTC_IRQHandler,Default_Handler

 .weak FLASH_IRQHandler
 .thumb_set FLASH_IRQHandler,Default_Handler

 .weak RCC_IRQHandler
 .thumb_set RCC_IRQHandler,Default_Handler

 .weak EXTI0_IRQHandler
 .thumb_set EXTI0_IRQHandler,Default_Handler

 .weak EXTI1_IRQHandler
 .thumb_set EXTI1_IRQHandler,Default_Handler

 .weak EXTI2_IRQHandler
 .thumb_set EXTI2_IRQHandler,Default_Handler

 .weak EXTI3_IRQHandler
 .thumb_set EXTI3_IRQHandler,Default_Handler

 .weak EXTI4_IRQHandler
 .thumb_set EXTI4_IRQHandler,Default_Handler

 .weak DMA1_Channel1_IRQHandler
 .thumb_set DMA1_Channel1_IRQHandler,Default_Handler

 .weak DMA1_Channel2_IRQHandler
 .thumb_set DMA1_Channel2_IRQHandler,Default_Handler

 .weak DMA1_Channel3_IRQHandler
 .thumb_set DMA1_Channel3_IRQHandler,Default_Handler

 .weak DMA1_Channel4_IRQHandler
 .thumb_set DMA1_Channel4_IRQHandler,Default_Handler

 .weak DMA1_Channel5_IRQHandler
 .thumb_set DMA1_Channel5_IRQHandler,Default_Handler

 .weak DMA1_Channel6_IRQHandler
 .thumb_set DMA1_Channel6_IRQHandler,Default_Handler

 .weak DMA1_Channel7_IRQHandler
 .thumb_set DMA1_Channel7_IRQHandler,Default_Handler

 .weak ADC1_2_IRQHandler
 .thumb_set ADC1_2_IRQHandler,Default_Handler

 .weak USB_HP_CAN1_TX_IRQHandler
 .thumb_set USB_HP_CAN1_TX_IRQHandler,Default_Handler

 .weak USB_LP_CAN1_RX0_IRQHandler
 .thumb_set USB_LP_CAN1_RX0_IRQHandler,Default_Handler

 .weak CAN1_RX1_IRQHandler
 .thumb_set CAN1_RX1_IRQHandler,Default_Handler

 .weak CAN1_SCE_IRQHandler
 .thumb_set CAN1_SCE_IRQHandler,Default_Handler

 .weak EXTI9_5_IRQHandler
 .thumb_set EXTI9_5_IRQHandler,Default_Handler

 .weak TIM1_BRK_IRQHandler
 .thumb_set TIM1_BRK_IRQHandler,Default_Handler

 .weak TIM1_UP_IRQHandler
 .thumb_set TIM1_UP_IRQHandler,Default_Handler

 .weak TIM1_TRG_COM_IRQHandler
 .thumb_set TIM1_TRG_COM_IRQHandler,Default_Handler

 .weak TIM1_CC_IRQHandler
 .thumb_set TIM1_CC_IRQHandler,Default_Handler

 .weak TIM2_IRQHandler
 .thumb_set TIM2_IRQHandler,Default_Handler

 .weak TIM3_IRQHandler
 .thumb_set TIM3_IRQHandler,Default_Handler

 .weak TIM4_IRQHandler
 .thumb_set TIM4_IRQHandler,Default_Handler

 .weak I2C1_EV_IRQHandler
 .thumb_set I2C1_EV_IRQHandler,Default_Handler

 .weak I2C1_ER_IRQHandler
 .thumb_set I2C1_ER_IRQHandler,Default_Handler

 .weak I2C2_EV_IRQHandler
 .thumb_set I2C2_EV_IRQHandler,Default_Handler

 .weak I2C2_ER_IRQHandler
 .thumb_set I2C2_ER_IRQHandler,Default_Handler

 .weak SPI1_IRQHandler
 .thumb_set SPI1_IRQHandler,Default_Handler

 .weak SPI2_IRQHandler
 .thumb_set SPI2_IRQHandler,Default_Handler

 .weak USART1_IRQHandler
 .thumb_set USART1_IRQHandler,Default_Handler

 .weak USART2_IRQHandler
 .thumb_set USART2_IRQHandler,Default_Handler

 .weak USART3_IRQHandler
 .thumb_set USART3_IRQHandler,Default_Handler

 .weak EXTI15_10_IRQHandler
 .thumb_set EXTI15_10_IRQHandler,Default_Handler

 .weak RTCAlarm_IRQHandler
 .thumb_set RTCAlarm_IRQHandler,Default_Handler

 .weak USBWakeUp_IRQHandler
 .thumb_set USBWakeUp_IRQHandler,Default_Handler
