import os
import subprocess
import argparse


CONTRACTS_PATH = './project/test_contracts'

def create_solutions():
    # filename -> [True=vulnerable contract | False=safe contract]
    vulnerable = {}

    # get user input for each file
    for f in os.listdir(CONTRACTS_PATH):
        print(f"{10*'-'}  {f}  {10*'-'}")
        with open(f'{CONTRACTS_PATH}/{f}', 'r') as file:
            content = file.read()            
            print(content)

            dec = ''
            while dec not in ['s', 'v', 'skip']:
                dec = input("Decision: ")
            
            if dec == 's':
                vulnerable[f] = False
            elif dec == 'v':
                vulnerable[f] = True
            else:
                print(f"Skipped file {f}.")

    # safe to file
    with open('./tests_solutions','w') as file:
        for k, v in vulnerable.items():
            file.write(f"{k},{v}\n")
    return


def get_solutions():
    with open('./tests_solutions_no_long', 'r') as file:
        content = file.read().rstrip()
        conv = lambda b: 'Tainted' if b else 'Safe'
        vulnerable = {e[0]: conv(e[1]=='True') for e in [l.split(',') for l in content.split('\n')]}
        return vulnerable


def run_tests(arg):
    
    solutions = get_solutions()
    score = 0
    no_passed = 0
    
    # if single test run argument was provided
    if arg:
        solutions = {arg+'.sol': solutions[arg+'.sol']}

    for f in solutions.keys():
        
        result  = subprocess.run(['python', './analyze.py', f'./test_contracts/{f}'], stdout=subprocess.PIPE).stdout.decode('utf-8').rstrip()

        # Test passed
        if solutions[f] == result:
            print(f"\033[92mPASSED:\033[0m {f}")
            score += result == 'Safe'
            no_passed += 1
            pass
        else:
            # Says Tainted, is Safe
            if result == 'Tainted':
                color = '\033[94m'
            # Says Safe, is Tainted
            else:
                color = '\033[91m'
                score -= 2

            print(f"{color}FAILED:\033[0m {f} expected: {solutions[f]}, got: {result}")

    if not args.t:
        no_safe_tests = len([v for k,v in solutions.items() if v == 'Safe'])
        print(f"Passed ({no_passed}/{len(solutions)}) with score ({score}/{no_safe_tests})")

    return

if __name__ == "__main__":
    # create_solutions()
    # get_solutions()

    parser = argparse.ArgumentParser()
    parser.add_argument('--t', type=str, required=False)
    args = parser.parse_args()

    run_tests(args.t)

