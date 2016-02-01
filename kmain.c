#include "gpio.h"
volatile unsigned int tim = 0;

void
kmain(void) {
	led0_enable();

	while (1) {
		for (tim = 0; tim < 500000; tim++);
		led0_on();

		for (tim = 0; tim < 500000; tim++);
		led0_off();
	}
}
