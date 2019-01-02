# Prevent rebuilding
VPATH = rules:rules/results

# Clean up after ourselves
.PHONY: clean
clean:
	rm -rf rules/results/

# Directories
results:
	mkdir -p rules/results

# Our tests
test: \
	MAGI-Children-HK1-result \
	MAGI-Children-HKE-result \
	MAGI-Children-LIF-result \
	MAGI-Children-Main-result | results
	sha256sum -c test.answers

MAGI-Children-HK1-result: MAGI-Children-HK1_test.sh MAGI-Children-HK1.py | results
	./rules/MAGI-Children-HK1_test.sh

MAGI-Children-HKE-result: MAGI-Children-HKE_test.sh MAGI-Children-HKE.py | results
	./rules/MAGI-Children-HKE_test.sh

MAGI-Children-LIF-result: MAGI-Children-LIF_test.sh MAGI-Children-LIF.py | results
	./rules/MAGI-Children-LIF_test.sh

MAGI-Children-Main-result: MAGI-Children-Main_test.sh MAGI-Children-Main.py | results
	./rules/MAGI-Children-Main_test.sh

# Generate test answers
.PHONY: Generate-test-answers
Generate-test-answers:
	sha256sum rules/results/* >| test.answers
