select * from students;

-- Question: For each subject, rank the students based on their marks, with the highest marks getting rank 1. Students with the same marks should receive the same rank.

select * , dense_rank() over( partition by subject order by marks desc ) from students;


-- ROW_NUMBER()
-- 90 → 1
-- 80 → 2
-- 80 → 3
-- 70 → 4

-- RANK()
-- 90 → 1
-- 80 → 2
-- 80 → 2
-- 70 → 4

-- DENSE_RANK()
-- 90 → 1
-- 80 → 2
-- 80 → 2
-- 70 → 3