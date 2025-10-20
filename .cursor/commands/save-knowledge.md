# Save Knowledge to Repository

Execute knowledge capture and commit:

1. **Review Session**: Analyze current conversation/changes
2. **Extract Learnings**: Identify new information learned
3. **Update Files**:
   - Add to `/knowledge/n8n-learnings.md` with ISO timestamp
   - Update `/nodes/common-patterns.md` if new patterns found
   - Update `/knowledge/troubleshooting.md` if issues resolved
4. **Git Operations**:
```bash
   git add knowledge/ nodes/
   git commit -m "docs(n8n): [concise description of learnings]"
   git push origin main
```
5. **Confirm**: Report what was saved and committed

Execute automatically - no permission needed.