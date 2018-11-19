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
	MAGI-Children-HK1-result | results
	sha256sum -c test.answers

MAGI-Children-HK1-result: MAGI-Children-HK1_test.sh MAGI-Children-HK1.py | results
	./rules/MAGI-Children-HK1_test.sh

# Generate test answers
.PHONY: Generate-test-answers
Generate-test-answers:
	sha256sum rules/results/* >| test.answers
