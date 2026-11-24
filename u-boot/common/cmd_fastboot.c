/*
 * Ingenic Fastboot Command Explain CMD
 *
 *  Copyright (C) 2013 Ingenic Semiconductor Co., LTD.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#include <common.h>
#include <command.h>
#include <asm/errno.h>
#include <g_fastboot.h>
#include <fastboot.h>

__attribute__ ((weak)) struct partition_info partition_info[16] = {
	[0] = {.pname = "uboot",   .offset = 0x0,       .size = 0x200000},
	[1] = {.pname = "kernel_a",.offset = 0x200000,  .size = 0x500000},
	[2] = {.pname = "kernel_b",.offset = 0x700000,  .size = 0x500000},
	[3] = {.pname = "root_a",  .offset = 0xc00000,  .size = 0x1400000},
	[4] = {.pname = "root_b",  .offset = 0x2000000, .size = 0x1400000},
	[5] = {.pname = "lullaby", .offset = 0x3400000, .size = 0x2000000},
	[6] = {.pname = "info",    .offset = 0x5400000, .size = 0x100000},
	[7] = {.pname = "flag",    .offset = 0x5500000, .size = 0x80000},
	[8] = {.pname = "flag1",   .offset = 0x5580000, .size = 0x80000},
	[9] = {.pname = "config",  .offset = 0x5600000, .size = 0x8000000},
};

static int do_fastboot(cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[])
{
	char *s = "fastboot";

	if (argc > 1)
		return CMD_RET_USAGE;

	g_fastboot_register(s);

	handle_fastboot_cmd();

	g_fastboot_unregister();

	return CMD_RET_SUCCESS;
}

U_BOOT_CMD(
	fastboot, 1, 1, do_fastboot,
	"enter fastboot mode",
	"enter fastboot mode"
);