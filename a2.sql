SELECT a.date,a.number,a.content,a.rating
FROM quotes a
LEFT JOIN quotes b
ON a.date = b.date
AND a.rating < b.rating
WHERE b.number IS NULL;

