#! /usr/bin/env python

import os
import argparse
import subprocess


def test_file(path, arg):
    """
    For a given path to the executable and a provided input, returns the executables output
    """
    proc = subprocess.Popen(["./"+path], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    output = proc.communicate(input=arg)[0]
    return output


def find_and_test(code_dir, problem_name, args, solutions):
    """
    Used to test a nested directory of solutions
    """
    for root, subdir, files in os.walk(code_dir):
        for filename in files:
            if problem_name in filename: 
                problem_path = os.path.join(root, filename)

                for arg, sol in zip(args, solutions):
                    output = test_file(problem_path, arg)
                    # a bit lenient, should check later
                    if sol.strip() in output: 
                        print("{0}: {1} -> {2} \033[0;32mCORRECT!\033[0m".format(filename, arg.strip(), output.strip()))
                    else:
                        print("{0}: {1} -> {2} \033[0;31mFALSE, should be {3}!\033[0m".format(filename, arg.strip(),
                            output.strip(), sol.strip()))


def load_args_solutions(bench_path):
    args = []
    sols = []
    with open(bench_path, 'r') as f:
        lines = f.readlines()
        for line in lines:
            arg, sol = line.split('->')
            args.append(arg)
            sols.append(sol)

    return args, sols


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--code_dir', '-c', default='.', help='The directory to be searched for code') 
    parser.add_argument('--problem_name', '-p', help='The problem name')
    parser.add_argument('--benchmark_path', '-b', help='A file with inputs and outputs to be tested')
    parser.add_argument('--verbose', '-v', type=bool, default=True, help='Verbosity')

    args = parser.parse_args()

    inputs, solutions = load_args_solutions(args.benchmark_path)

    find_and_test(args.code_dir, args.problem_name, inputs, solutions)

