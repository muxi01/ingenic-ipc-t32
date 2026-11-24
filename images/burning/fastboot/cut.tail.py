#!/usr/bin/python3

import os
import sys
import argparse
from collections import deque


def parse_block_size(size_str):
    """
    解析块大小字符串，支持 '64k', '128K', '1024' 等格式。
    返回字节数 (int)。
    """
    size_str = size_str.strip().lower()
    if size_str.endswith('k'):
        try:
            return int(size_str[:-1]) * 1024
        except ValueError:
            raise argparse.ArgumentTypeError(f"无法解析的块大小格式: {size_str}")
    else:
        try:
            return int(size_str)
        except ValueError:
            raise argparse.ArgumentTypeError(f"无法解析的块大小格式: {size_str}")

def trim_trailing_ff(input_file, output_file, block_size):
    """
    裁剪二进制文件末尾的全FF块。
    逻辑：按block_size分块读取存入链表，从尾部检查并丢弃全FF块，最后写入新文件。
    """
    if not os.path.exists(input_file):
        print(f"错误：输入文件 {input_file} 不存在。")
        return

    buffer_list = deque()
    ff_block = b'\xff' * block_size

    print(f"开始处理文件: {input_file} (块大小: {block_size} 字节 / {block_size//1024} KB)...")

    try:
        # 1. 读取文件并构建 buffer 链表
        with open(input_file, 'rb') as f:
            while True:
                chunk = f.read(block_size)
                if not chunk:
                    break
                
                # 如果读取的内容不足 block_size（即文件末尾），需要补齐为全FF
                if len(chunk) < block_size:
                    chunk += b'\xff' * (block_size - len(chunk))
                
                buffer_list.append(chunk)
        
        if not buffer_list:
            print("输入文件为空。")
            return

        print(f"共读取 {len(buffer_list)} 个数据块。")

        # 2. 从最后一个 buffer 开始检索，如果全为FF则丢弃
        trimmed_count = 0
        while buffer_list:
            last_block = buffer_list[-1]
            
            if last_block == ff_block:
                buffer_list.pop()
                trimmed_count += 1
            else:
                break
        
        if trimmed_count > 0:
            print(f"检测到末尾有 {trimmed_count} 个全FF块，已丢弃。")
        else:
            print("文件末尾没有全FF块，无需裁剪。")

        # 3. 将剩余内容写入新文件
        with open(output_file, 'wb') as f:
            for block in buffer_list:
                f.write(block)
                
        final_size = len(buffer_list) * block_size
        print(f"处理完成！新文件已保存至: {output_file} (大小: {final_size} 字节)")

    except Exception as e:
        print(f"处理过程中发生错误: {e}")

def main():
    # 创建 ArgumentParser 对象，添加程序描述
    parser = argparse.ArgumentParser(
        description="裁剪二进制文件末尾的全 0xFF 数据块工具。",
        epilog="示例:\n"
               "  python trim_ff.py input.bin\n"
               "  python trim_ff.py input.bin output.bin\n"
               "  python trim_ff.py input.bin output.bin 128k\n",
        formatter_class=argparse.RawTextHelpFormatter
    )
    
    # 添加参数
    parser.add_argument("input", help="输入的二进制文件路径")
    parser.add_argument("output", nargs="?", default="output.bin", help="输出的二进制文件路径 (默认: output.bin)")
    parser.add_argument("-b", "--block", type=parse_block_size, default="64k", 
                        help="指定块大小，支持带 'k' 或 'K' 后缀 (默认: 64k)")

    # 解析参数
    args = parser.parse_args()

    # 调用核心处理函数
    trim_trailing_ff(args.input, args.output, args.block)

if __name__ == "__main__":
    main()

